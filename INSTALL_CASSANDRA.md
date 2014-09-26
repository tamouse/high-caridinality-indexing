  340  cd Projects/rubystuff/railsapps/cassandra-nosql/
  341  rails new
  342  rails help
  343  rails new high-caridinality-indexing --no-rc --skip-active-record --skip-action-view --skip-sprockets --skip-spring --skip-javascript -T -p
  344  rails new high-caridinality-indexing --no-rc --skip-active-record --skip-action-view --skip-sprockets --skip-spring --skip-javascript -T
  345  bundle
  346  cd high-caridinality-indexing/
  347  bundle
  348  which rails
  349  echo $PATH
  350  export PATH=./bin:$PATH
  351  which rails
  352  rails g cucumber:install --help
  353  rails g cequel:configuration
  354  more config/cequel.yml 
  355  java -version
  356  pushd ~/src/
  357  curl -O http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jre-8u20-linux-x64.rpm
  358  cp ../Projects/java-jre/jre-8u20-linux-x64.gz .
  359  mv jre-8u20-linux-x64.gz jre-8u20-linux-x64.tar.gz 
  360  ll
  361  sudo -i
  362  popd
  363  java -version
  364  sudo apt-get install libjna-java
  365  echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
  366  more /etc/apt/sources.list.d/cassandra.sources.list 
  367  curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
  368  sudo apt-get update
  369  sudo apt-get install dsc20 -y
  370  aptitude search dsc
  371  sudo apt-get install dsc21 -y

  376  sudo service cassandra stop
  377  sudo rm -rf /var/lib/cassandra/data/system/*
  378  ll /etc/cassandra/
  379  more /etc/cassandra/cassandra.yaml 
  380  sudo emacs /etc/cassandra/cassandra.yaml 
  381  sudo service cassandra start
  382  nodetool status

