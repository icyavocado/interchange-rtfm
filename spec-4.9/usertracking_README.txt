NAME
       Interchange Usertracking

VERSION
       $Revision: 1.3 $ $Id: README,v 1.3 2001/08/15 13:23:03
       racke Exp $

DESCRIPTION
       Usertracking is a useful feature to get a grip on
       customer's desires.

ENHANCEMENTS
       DEACTIVATION
           Currently the usertracking is always on. As we add
           features to the usertracking, we should supply a
           configuration directive to switch usertracking off.
           Maybe something cute like enabling usertracking by

                   Require Vend::Track

           would be possible.

       TRACK CGI PARAMETERS
           Jojo <jojo@blackpoint.de> asked for a way to log
           certain CGI parameters, in this case item_id on
           admin/item_edit. I suggested to implement the
           following directive:

                   TrackPageParam admin/item_edit item_id


       TRACK SEARCH PARAMETERS
           Tracking the search parameters would be another nice
           idea.

STATUS
       TrackPageParam has been already implemented.

AUTHOR
       Stefan Hornburg (Racke), racke@linuxia.de
