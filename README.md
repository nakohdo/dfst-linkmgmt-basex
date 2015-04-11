# dfst-linkmgmt-basex
Link management application implemented using the BaseX XQuery database

This module provides a combination of XQuery modules and Web applications
that provide basic DITA-aware link management features:

* Where used: Where is a given element, topic, map, or non-DITA resource used?
* Dependency tracking: What are the things a given map or topic depends on?
* DITA-aware search: Find elements based on their DITA properties
* Quick HTML preview of DITA content
* Key space knowledge management: Maintain knowledge of all key spaces defined in all the maps in the repository
* Key resolution services: A REST API that takes the key space, key name, and applicability conditions, and returns either the applicable key definitions or the resources ultimately referenced by those key definitions (if any).

## Implementation Approach

This code depends on the BaseX-specific git commit hooks provided in the dfst-git-commit-hooks project. Those 
commit hooks store copies of the DITA documents into the BaseX repository, keeping the XQuery database in sync with 
the git repository as commits are made.

Within BaseX, each branch of each repository is represented as a separate BaseX database. This allows for
easy querying within a specific repository and branch. In order to keep things efficient and
minimize the disk size of the BaseX databases, the BaseX repository only 
reflects the latest commit on a given branch. 

It would be possible to store each commit as a separate BaseX database,
but this would start to use a lot of storage. As a future refinement it might make sense to keep tagged
commits as separate BaseX databases inorder to be able to search against older versions (this might be required
for some linking use cases where documents need to be able to link to older versions of specific resources).   
It could also be possible to only create commit-specific databases when links to those older versions are
created.


