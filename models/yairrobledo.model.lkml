# Define the database connection to be used for this model.
connection: "national_parks"

# include all the views
include: "/views/**/*.view"
# include: "/views/park_state.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: yairrobledo_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: yairrobledo_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Yairrobledo"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.



explore: parks {
  join: park_species {
    type: left_outer
    sql_on: ${parks.park_name} = ${park_species.park_name};;
    relationship: one_to_many
  }
  join: detailed_visits {
    type: left_outer
    sql_on: ${parks.park_name} = ${detailed_visits.park};;
    relationship: one_to_many
  }
  join: trails {
    type: left_outer
    sql_on: ${parks.park_name} = ${trails.area_name};;
    relationship: one_to_many
  }
  join: park_climate {
    type: left_outer
    sql_on: ${parks.park_name} = ${park_climate.park};;
    relationship: one_to_many
  }
  join: climbing {
    type: left_outer
    sql_on: ${parks.park_name} = ${climbing.park};;
    relationship: one_to_many
  }
  join: monthly_visits{
    type: left_outer
    sql_on: ${parks.park_name} = ${monthly_visits.park};;
    relationship: one_to_many
  }
  # join: park_state {
  #   view_label: "Top N Ranking"
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${parks.park_name} = ${park_state.park_name} ;;
  # }
}

explore: park_state {}

explore: park_species {}

explore: detailed_visits {}

explore: trails {}

explore: park_climate {}

explore: climbing {}

explore: monthly_visits {}

explore: guides {}

explore: park_noaa_stations {}

explore: detailed_weather {}

# explore: detailed_climate {}
