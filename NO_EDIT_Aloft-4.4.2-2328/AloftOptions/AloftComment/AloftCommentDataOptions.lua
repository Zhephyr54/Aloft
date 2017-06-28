local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCommentDataOptions
if not L then return end

local AloftCommentData = Aloft:GetModule("CommentData", true)
if not AloftCommentData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.comment =
{
	type = 'group',
	name = L["Comments"],
	desc = L["Comment options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCommentData:IsEnabled() or not AloftCommentData.db or not AloftCommentData.db.profile end,
	args =
	{
		save =
		{
			type = 'toggle',
			width = 'full',
			name = L["Save Comment Data"],
			desc = L["Stores comment data between sessions"],
			get = function(i) return AloftCommentData.db.profile.save end,
			order = 1,
			set = AloftCommentData.SetSaveData,
		},
		auto =
		{
			type = 'toggle',
			width = 'full',
			name = L["Automatic Comments"],
			desc = L["Automatically set comments from tooltip tags"],
			order = 2,
			get = function(i) return AloftCommentData.db.profile.auto end,
			set = function(i, v)
					AloftCommentData.db.profile.auto = v
					AloftCommentData:RegisterEvents()
				  end,
		},
		includeHostile =
		{
			type = 'toggle',
			width = 'full',
			name = L["Include Hostile Units"],
			desc = L["Include hostile units when automatically gathering comments"],
			order = 3,
			disabled = function(i) return not AloftCommentData.db.profile.auto end,
			get = function(i) return AloftCommentData.db.profile.includeHostile end,
			set = function(i, v) AloftCommentData.db.profile.includeHostile = v end,
		},
		clear =
		{
			type = 'execute',
			width = 'full',
			name = L["Reset Comments"],
			desc = L["Empties the comment database"],
			func = function(i) AloftCommentData:ClearAllData() end,
			order = -1,
			confirm = function(i) return L["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] end,
		},
	}
}

-----------------------------------------------------------------------------

end)
