connection: "private_internal" #this needs to be personalized

include: "*.view.lkml"                       # include all views in this project
include: "*.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "*.explore.lkml"

explore: balance_sheet {
  extends: [balance_sheet_config]
}

explore: income_statement {
  extends: [income_statement_config]
}

explore: transaction_details {
  extends: [transaction_details_config]
}
