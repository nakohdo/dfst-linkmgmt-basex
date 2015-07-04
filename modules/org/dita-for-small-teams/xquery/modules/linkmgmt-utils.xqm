(: =====================================================

   DITA Link Management Utilities
   
   Utilities that support general DITA link management 
   actions.
   
   Author: W. Eliot Kimber
   
   Copyright (c) 2015 DITA For Small Teams
   Licensed under Apache License 2
   

   ===================================================== :)

module namespace lmutil="http://dita-for-small-teams.org/xquery/modules/linkmgmt-utils";

import module namespace df="http://dita-for-small-teams.org/xquery/modules/dita-utils";

declare function lmutil:findAllLinks($dbName) as element()* {
  let $db := db:open($dbName)
  let $links := collection($dbName)//*[df:isTopicRef(.)] |
                collection($dbName)//*[contains(@class, ' topic/xref ')] |
                collection($dbName)//*[contains(@class, ' topic/data-about ')] |
                collection($dbName)//*[contains(@class, ' topic/longdescref ')] |
                collection($dbName)//*[@conref] |
                collection($dbName)//*[@conkeyref] |
                collection($dbName)//*[@keyref]
   return $links
};

(: Given a link and the database that contains it, attempts
   to resolve the link to an element (in DITA a given link
   can address at most one element).
   
   Returns a map with the following members:
   'target': A sequence of zero or more elements addressed
             by the link.
   'log':    A sequence of zero or more log entry elements 
             generated by the resolution attempt.
 :)
declare function lmutil:resolveLink($dbName, $link) as map(*) {

   let $target := (<p id="p1">Bogus target element </p>)
   let $log := (<error>Link resolution not yet implemented</error>)
   return map{'target' : $target, 'log' : $log}
};

(: End of Module :)