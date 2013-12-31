crumb :home do
  link "Home", root_path
end

crumb :users do
  link "Users", users_path
  parent :home
end

crumb :scores do
  link "Scores", scores_path
  parent :home
end

crumb :characters do
  link "Characters", characters_path
  parent :home
end

crumb :character_bots do
  link "Character_bots", character_bots_path
  parent :home
end

crumb :races do
  link "Races", races_path
  parent :home
end

crumb :items do
  link "Items", items_path
  parent :home
end

crumb :item_groups do
  link "Item Groups", item_groups_path
  parent :home
end

crumb :item_types do
  link "Item Types", item_types_path
  parent :home
end

crumb :user_items do
  link "User Items", user_items_path
  parent :home
end


crumb :versions do
  link "Versions", versions_path
  parent :home
end



crumb :statics do
  link "statics", '#'
  parent :home
end

# user detail
crumb :user do |user|
  link user.username, user
  parent :users
end

# Character detail
crumb :character do |character|
  link character.char_name, character
  parent :characters
end

crumb :character_bot do |character_bot|
  link character_bot.char_name, character_bot
  parent :character_bots
end

crumb :race do |race|
  link race.char_race, race
  parent :races
end

crumb :score do |score|
  link score.created_at, score
  parent :scores
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).