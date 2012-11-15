
<%

--[[
@title: Control request statistical query .
@goal: Obtain from model layer and transmits to view layer the result of the statistical query requested.
@context:
	localization: control layer.
	precondition: REQUEST KEYWORDS USED BY THE AUTHORS.
@actors: system.
@resources: query to be performed, first parameter(optional)
]]--

--@episode 1: imports the configuration file and sets the correct path.
dofile("../config/config.lua")	
package.path = package.path..returnDLPath()

--@episode 2: imports model_event and iconv module to charset tranformation
local model_event = require("model.model_event")
require ("iconv")
local cd = iconv.new("ISO-8859-1", "ISO-8859-1")

--@episode 3: imports model_event and iconv module to charset tranformation
local statistical_query = cgilua.QUERY.statistical_query
local first_parameter = ""


if (statistical_query == "keywordsUsedByAuthor") then


--episode 4: if the statisticas query is keywordsUsedByAuthor then RETURN KEYWORDS USED BY AUTHOR.
	local keywords_authors = model_event.returnKeywordsUsedByAuthors()
	local table_size = table.getn(keywords_authors)
	json_obj = ""

--episode 5: assembles the json object according to the data returned.
	for i, v in pairs(keywords_authors) do

		local keyword = (keywords_authors[i]["k"])
		keyword = string.gsub(keyword, "\n", " ")	
		keyword = string.gsub(keyword, "\r", " ")
		keyword = string.gsub(keyword, "\b", " ")    
		keyword = string.gsub(keyword, "\t", " ")
		keyword = cd:iconv(keyword)
		local author = cd:iconv(keywords_authors[i]["author"])	
		
		json_obj = json_obj .. [[
			{
				"author":"]]..author..[[",
				"k":"]]..keyword..[[",
				"contador":"]]..keywords_authors[i]["contador"]..[["
			}
		]]

--episode 6: puts a comma after each element in the json object, except the last one.
		if (i < table_size) then
			json_obj = json_obj..","
		end	


	end

	json_obj = "["..json_obj.."]"
	cgilua.contentheader("application" , "xml; charset=iso-8859-1")
	
--episode 7: returns the json object.
	cgilua.put(json_obj)

else

--episode 8: if the query informed was not found, then retuns and error.
	cgilua.contentheader("application" , "xml; charset=iso-8859-1")
	cgilua.put([[

		{
			"Error": "Control Layer - statistical query not found"
		}
	]])
end 
%>
