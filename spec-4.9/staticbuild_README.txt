NAME
       Static Page Building

VERSION
       $Revision: 1.2 $ $Id: README,v 1.2 2001/10/08 10:22:15
       racke Exp $

DESCRIPTION
       Static page building in recent Interchange is quite
       useless.

CONFIGURATION
       Static

       I'll change the documentation from:

       Enables static page building and display features.

       to:

       Enables static display features. Static page building is
       independent from this setting so you can prepare static
       pages for other purposes than displaying them instead of
       dynamic generated pages.

       StaticIndex

       Entry point for the static page building, e.g.:

               StaticIndex     dir


       StaticSessionDefault

       This can be used to put key/values pair in the session
       used for static page building, e.g.:

               StaticSessionDefault store_id demo


AUTHOR
       Stefan Hornburg (Racke), racke@linuxia.de
