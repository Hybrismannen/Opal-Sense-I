# Projects, Issues and Wiki — deployment guide

## Current state
Issues have been created and issue templates are version-controlled. GitHub's repository flags for Projects and Wiki are enabled. These flags do **not** by themselves create a Project v2 or Wiki Home.

## Editorial Project v2 (owner: Hybrismannen)
Create a user Project titled **The Opal — Editorial & Archive Operations**. Link it to this repository. Add the following custom fields:
- Editorial Phase: Backlog, Sourcing, Researching, Fact-check, Drafting, Editing, Published
- Desk: Culture & Identity, Garments & Traditions, Designers & Houses, Objects & Engineering, Global Observer, Reading Room, Platform
- Priority: P0, P1, P2, P3
- Evidence: Unverified, Partially sourced, Source verified, Reviewed
- Next Review: date

Views: Editorial Kanban (by Editorial Phase), Research Desk (table by Desk), Evidence Review and Publications Roadmap.

Add repository Issues to the Project; keep their native GitHub state as Open until acceptance criteria are met. Use custom Editorial Phase for intermediate stages.

GitHub Projects v2 is a **user/account resource**, not a repository file. It requires project-management authorization separate from normal repository Contents/Issues permissions.

## Wiki activation
Go to the repository Wiki tab and save the first page titled **Home**. The Wiki is a separate git repository with a .wiki.git suffix. The prepared Home and navigation pages in docs/wiki-seed may then be copied into it. Do not claim it exists merely because the wiki feature is enabled.

## Privacy and source controls
The public repo should contain publicly shareable editorial work only. Avoid seller screenshots, personal receipts, or copies of protected editorial photographs.
