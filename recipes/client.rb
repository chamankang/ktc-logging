#
# CookBook:: ktc-logging
# Recipe:: client
#

# include recipes from our run_list attribute
#
node[:logging][:recipes_client].each do |recipe|
  include_recipe recipe
end
