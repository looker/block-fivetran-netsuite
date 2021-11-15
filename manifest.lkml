project_name: "block-fivetran-netsuite"

################ Constants ################

constant: CONNECTION_NAME {
  value: "select"
  export: override_optional
}

constant: SCHEMA_NAME {
  value: "netsuite"
  export: override_optional
}
