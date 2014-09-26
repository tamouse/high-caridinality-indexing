# Testing Cassandra High-Cardinality Indexing Implementations

On a project, I've been learning how to use the [Cassandra Database][cassandra] with Rails.

In particular, the service (an API-only micro-web service) requires the ability to quickly look up a set of records by non-primary-key entries. As most of these are **high-cardinality** fields, using secondary indexes will not be performant.[1][hcperf]

Thus we need to make index tables and manually keep track of them ourselves.

## INSTALLATION

### REQUIREMENTS

* This application requires that [Cassandra][gettingstarted] be installed.
* We're using the [Cequel][cequel] gem for working with [Cassandra][gettingstarted].

### STEPS

This is not exhaustive, just the list of steps I took. This was on ubuntu server 12.04 vagrant box.

#### Install Java Runtime Environment

You have to install the Oracle JRE, you can't use OpenJDK for some reason.
This means you have to sign the license agreement on the Oracle site before
you can download it. I downloaded it to my project directory on my host machine,
then moved it where I could use it.

``` bash
cd ~/src/
cp ../Projects/java-jre/jre-8u20-linux-x64.gz .
mv jre-8u20-linux-x64.gz jre-8u20-linux-x64.tar.gz 
sudo mkdir -p /usr/lib/jvm
sudo tar zxvf jre-8u20-linux-x64.tar.gz -C /usr/lib/jvm

java -version

sudo apt-get install libjna-java
```

#### Install Cassandra

``` bash
echo "deb http://debian.datastax.com/community stable main" | \
  sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -

sudo apt-get update
sudo apt-get install dsc21 -y

# for testing purposes, the default "Test Config" is fine
nodetool status
```

## Creating an initial Rails project

You should just be able to clone this repo, but these are the steps I used to set up the rails app initially:

``` bash
cd Projects/rubystuff/railsapps/cassandra-nosql/
rails new high-caridinality-indexing --no-rc --skip-active-record --skip-action-view \
  --skip-sprockets --skip-spring --skip-javascript --skip-bundle --skip-test-unit
cd high-caridinality-indexing/
```

Add cequel to your Gemfile:

    gem 'cequel', '~> 1.4.1'

Then `bundle install` and you should be good to start development.

## Cloning this repository

Just do the typical:

    git clone https://github.com/tamouse/high-cardinality-indexing.git
    cd high-cardinality-indexing
    bundle install
    bin/rake cequel:init


## Making High-Cardinality Indexes

We need to make index tables that collect the id's of the main table. This is pretty simple, but it requires some manual steps to make things work properly.

### Person Table

Given a main data table for a person, we have columns:

* id, a UUID, automatically generated
* family name
* given name
* email
* phone

``` ruby
class Person
  include Cequel::Record
  # include ActiveModel::Serialization

  key :id, :uuid, auto: true

  column :family_name, :text
  column :given_name,  :text
  column :email,       :text
  column :phone,       :text
end
```

The service can quickly provide a person record given the id. But what if you want to look up any of the other fields quickly? First blush one might think of putting a secondary index on the fields, but it turns out this does not work well with Cassandra, as it may blow performance right out of the water if crossing partitions, and digging through records.

So instead, we create a lookup table to provide the indexing.

For each of the fields, we'd want to provide such a table. Looking at just the lookup for the family name, we create a table:

* id, a text field to contain the matching family name
* people_ids, a [*set*][cql_set] to contain the UUIDs of all the matching person records.

``` ruby
class FamilyNameIdx
  include Cequel::Record
  key :id, :text
  set :people_ids, :uuid
end
```

Now we need to wire these together. We'll provide a *class* method on `FamilyNameIdx` to update the index:

``` ruby
def self.update_index(id:, person_id:)
  index = new(id: id)
  index.people_ids << person_id
  index.send(:update)
  find_by_id(id)
end
```

This will called from the `Person` model in a callback when the record is saved. We'll also make a method to enable us to retrieve all the people that have the same family name.

``` ruby
after_save :update_indexes

# ...

# Finders
def self.find_all_by_family_name(q)
  where(id: FamilyNameIdx.find_people_ids(q).to_a)
end

# ...

private

def update_indexes
  FamilyNameIdx.update_index(id: self.family_name, person_id: self.id) if self.family_name
end
```

Similarly, we'll wire up the remaining indexes. Judiciously using the same field names in each lookup table allows us to also pull out the `update_indexes` method, and another method, `find_people_ids` which will be used in finders above, into a concern, `LookupIndex` to keep things DRY.




<!-- References -->

[cassandra]: http://cassandra.apache.org/ 

[gettingstarted]: http://www.datastax.com/documentation/cassandra/2.1/cassandra/gettingStartedCassandraIntro.html

[hcperf]: http://www.datastax.com/documentation/cql/3.1/cql/ddl/ddl_when_use_index_c.html?scroll=concept_ds_sgh_yzz_zj__when-no-index 

[ceque]: https://github.com/cequel/cequel 

[cqlset]: http://www.datastax.com/documentation/cql/3.1/cql/cql_using/use_set_t.html "CQL Set Documentation" 
