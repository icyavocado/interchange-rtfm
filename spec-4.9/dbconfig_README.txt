NAME
       Database configuration via the Interchange UI

VERSION
       $Revision: 1.2 $ $Id: README,v 1.2 2001/08/03 13:44:32
       heins Exp $

DESCRIPTION OF PROBLEM
       Many users of Interchange have a hard time dealing with
       all the pieces of the puzzle in creating, modifying, and
       updating a database table.  With the diverse underlying
       database types in Interchange, it can be a bit of a burden
       not only for the user but the programmer in dealing with.

GOALS
       Define a set of database configuration capabilities to
       include:

       Reliability
           The most important thing is to never, never, lose data
           as a result of a configuration operation. This may
           take the form of backups, warnings, and other methods
           of ensuring people will not inadvertantly blow away
           their database.

       Universality
           Applications like PHPmysqlAdmin and Perl modules such
           as DBIx::Schema offer nice capabilites in this regard,
           but are only portable to one or two database types.
           The goal is to provide a templating framework based on
           SQL standards or export/reimport, one that fits all
           supported database types.

       Ease of use
           This is key, because the task is possible using
           existing tools. Ease of use is the only reason for
           this proposal.

       Performance
           As much as possible in view of the overriding
           reliability concern, catalog/server downtime for
           reconfiguration tasks should be eliminated or
           minimized.

FEATURES
       ·   Mix and match database table types

       ·   Field type, length, and constraint attributes when
           applicable, falling back to the attributes specified
           by default %known_capability setting

       ·   Set overall DB connection parameters like ChopBlanks,
           etc.

       ·   Add columns

       ·   Change column names and types

       ·   Add tables

       ·   Remove tables

AUTHOR
       Mike Heins, <mheins@redhat.com>
