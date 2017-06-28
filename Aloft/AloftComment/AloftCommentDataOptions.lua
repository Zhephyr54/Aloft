local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CommentData") then return end

local AloftCommentData = Aloft:GetModule("CommentData")
local L = AceLibrary("AceLocale-2.2"):new("AloftCommentDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.comment =
{
	type = 'group',
	name = L["Comments"],
	desc = L["Comment options"],
	args =
	{
		save =
		{
			type = 'toggle',
			name = L["Save Comment Data"],
			desc = L["Stores comment data between sessions"],
			get = function() return AloftCommentData.db.profile.save end,
			order = 1,
			set = AloftCommentData.SetSaveData
		},
		auto =
		{
			type = 'toggle',
			name = L["Automatic Comments"],
			desc = L["Automatically set comments from tooltip tags"],
			order = 2,
			get = function() return AloftCommentData.db.profile.auto end,
			set = function(v)
					AloftCommentData.db.profile.auto = v
					AloftCommentData:RegisterEvents()
				  end,
		},
		includeHostile =
		{
			type = 'toggle',
			name = L["   Include Hostile Units"],
			desc = L["Include hostile units when automatically gathering comments"],
			order = 3,
			disabled = function() return not AloftCommentData.db.profile.auto end,
			get = function() return AloftCommentData.db.profile.includeHostile end,
			set = function(v) AloftCommentData.db.profile.includeHostile = v end,
		},
		clear =
		{
			type = "execute",
			name = L["Reset Comments"],
			desc = L["Empties the comment database"],
			func = function() AloftCommentData:ClearAllData() end,
			order = -1,
			confirm = L["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"]
		},
	}
}

-----------------------------------------------------------------------------

end)
