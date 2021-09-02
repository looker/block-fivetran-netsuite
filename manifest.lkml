project_name: "block-fivetran-netsuite"

################ Constants ################

constant: CONFIG_PROJECT_NAME {
  value: "block-fivetran-netsuite-config"
  export: override_required
}

constant: CONNECTION_NAME {
  value: "select"
  export: override_required
}

constant: SCHEMA_NAME {
  value: "netsuite_suiteanalytics"
  export: override_required
}

################ Dependencies ################

local_dependency: {
  project: "@{CONFIG_PROJECT_NAME}"

  override_constant: SCHEMA_NAME {
    value: "@{SCHEMA_NAME}"
  }
}
