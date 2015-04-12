(:~
 : DITA for Small Teams
 :
 : Link management application RESTXQ implementation.
 :
 : Copyright (c) 2015 DITA for Small Teams (dita-for-small-teams.org)
 :
 : See the BaseX RESTXQ documentation for details on how the RESTXQ 
 : mechanism works.
 :
 :)
module namespace page = 'http://basex.org/modules/web-page';

import module namespace bxutil="http://dita-for-small-teams.org/xquery/modules/basex-utils";

(:~
 : This function generates the welcome page.
 : @return HTML page
 :)
declare
  %rest:path("/")
  %output:method("xhtml")
  %output:omit-xml-declaration("no")
  %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
  %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
  function page:start()
  as element(Q{http://www.w3.org/1999/xhtml}html)
{
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>DITA for Small Teams Link Manager</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <div class="right">
      <p><a href="http://www.dita-for-small-teams.org" target="dfst-home">www.dita-for-small-teams.org</a></p>
      <p><img src="static/dita_logo.svg" width="150"/></p>
      </div>
      <div class="title-block">
        <h2>DITA for Small Teams Link Manager</h2>
      </div>
      <div class="action-block">
        <div>
          <h3>Repositories and Branches</h3>
          <table>
            <thead>
              <tr>
                <th>Repository</th>
                <th>Branches</th>
              </tr>
            </thead>
            <tbody>
            {page:listReposAndBranches()}
           </tbody>
          </table>
        </div>
      </div>
    </body>
  </html>
};

(:~
 : List the databases that represent git repositories and branches
 : within those repositories.
 :
 : Result is a set of HTML table rows.
 :)
 declare function page:listReposAndBranches() as element()* {
 
    (: Get the repository info as an XML structure :)
    let $repos := bxutil:getGitRepositoryInfos()
    for $repo in $repos (: Sequence of <repo> elements :)
        return (
        <tr>
         <td rowspan="{$repo/@branchCount}">{string($repo/name)}</td>
         <td>{string($repo/branch[1]/name)}</td>
        </tr>,
        for $branch in $repo/branch[position() gt 1]
            return 
              <tr>
               <td>{string($branch/name)}</td>
              </tr>
        ) 
        (:
    <tr>
      <td rowspan="2">some repo</td>
      <td>master</td>
    </tr>,
    <tr>
      <td>develop</td>
    </tr>
    :)
 };

(:~
 : This function returns an XML response message.
 : @param $world  string to be included in the response
 : @return response element 
 :)
declare
  %rest:path("/linkmgr")
  %rest:GET
  function page:linkmgr(
    )
    as element(response)
{
  <response>
    <title>Linkmgr</title>
    <time>Link manager response: The current time is: { current-time() }</time>
  </response>
};

