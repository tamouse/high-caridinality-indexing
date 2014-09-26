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




<!-- References -->

[cassandra]: http://cassandra.apache.org/ 

[gettingstarted]: http://www.datastax.com/documentation/cassandra/2.1/cassandra/gettingStartedCassandraIntro.html

[hcperf]: http://www.datastax.com/documentation/cql/3.1/cql/ddl/ddl_when_use_index_c.html?scroll=concept_ds_sgh_yzz_zj__when-no-index 
