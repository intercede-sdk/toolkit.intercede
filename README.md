Content for https://intercede-sdk.github.io/toolkit.intercede/

New version process:

- Edit root index.html: replace current version (e.g. 2026.1) with new version (e.g. 2026.2)
- Copy a version subfolder (e.g. v2026.1) to a new version subfolder (e.g. v2026.2)
  - Edit index.html within new folder and replace old version (e.g. 2026.1) with new version (e.g. 2026.2)
- Add an additional entry versions.html. Note that latest version points to root index.html
  - This new entry will be for the latest version, and will point to root index.html
  - The previous top entry then needs to point to the folder that was created for it in the previous version. That is, the item that _used_ to point to index.html should point to `v2026.1/`, for example
