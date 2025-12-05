### ==== Chronicles Project Structure ====

Chronicles is adopting a component level project structure

Important directories are listed as such:

- `/__Framework`
    - ...<Framework Features>
- `/__Game`
    - `/_DM/`
        - `/Atom/`
            - `/Area/`
            - `/Movable/`
                - `/Mob/`
                - `/Obj/`
            - `/Turf/`
        - `/Client/`
        ...<Any Additional DM Overrides>
    ...<Game Features>

* The slashes aren't necessary, they're only there to reference directories
* ...<ID> means any other similar items to the above

DON'T add game specific features to `__Framework`, this is reserved for non-content features
DON'T add non-DM object definitions to `__Game/_DM`, this is reserved for non-feature-specific
    overrides and additions to the DM objects themselves
DO create directories for new features, you may override extended objects in these,
    but not directly modify DM objects

#### == Component Structure ==

Components should be laid out like so

- `/FeatureName/`
    - `/SubFeatureName/`
    ...<Any Other Subfeatures>
    - `FeatureName.Structure.Extension`

* The slashes aren't necessary, they're only there to reference directories
* ...<ID> means any other similar items to the above
* Structure means content type, for example a wrapper, or DM definitions such as
    - `Vars`, `Procs`, `Verbs`, `<DM_ProcName>` ie `New`, `Del`, `Login`
* Extension means the file extension, mostly `.dm`

DO organize subfeatures the same as regular features
DO nest subfeatures within features when there's a hierarchical relationship
DO nest subfeatures within subfeatures when there's a hierarchical relationship
    - If an extension to something is only used within the context of it's parent
        it should be considered a subfeature
DON'T modify features within another feature

