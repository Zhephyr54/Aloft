local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftRaidIconOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Raid Icon"] = true,
	--[[ enUS ]] ["Raid icon placement options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enable raid icon display on the nameplate"] = true,
	--[[ enUS ]] ["Size"] = true,
	--[[ enUS ]] ["Size in pixels of the raid icon"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust raid icon position"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the raid icon"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the raid icon"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the raid icon"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the raid icon"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the raid icon alpha"] = true,

	--[[ enUS ]] ["TOPLEFT"] = true,
	--[[ enUS ]] ["TOP"] = true,
	--[[ enUS ]] ["TOPRIGHT"] = true,
	--[[ enUS ]] ["LEFT"] = true,
	--[[ enUS ]] ["CENTER"] = true,
	--[[ enUS ]] ["RIGHT"] = true,
	--[[ enUS ]] ["BOTTOMLEFT"] = true,
	--[[ enUS ]] ["BOTTOM"] = true,
	--[[ enUS ]] ["BOTTOMRIGHT"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Raid Icon"] = "공격대 아이콘",
	--[[ koKR ]] ["Raid icon placement options"] = "공격대 아이콘 배치 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Enable raid icon display on the nameplate"] = "이름표에 공격대 아이콘을 표시합니다.",
	--[[ koKR ]] ["Size"] = "크기",
	--[[ koKR ]] ["Size in pixels of the raid icon"] = "공격대 아이콘의 크기입니다.",
	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust raid icon position"] = "공격대 아이콘 위치 조절",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the raid icon"] = "공격대 아이콘의 X 좌표 입니다.",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the raid icon"] = "공격대 아이콘의 Y 좌표 입니다.",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the raid icon"] = "공격대 아이콘의 앵커를 설정합니다.",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the raid icon"] = "생명력 바에서 공격대 아이콘의 앵커 위치를 설정합니다.",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the raid icon alpha"] = "공격대 아이콘의 투명도를 설정합니다.",

	--[[ koKR ]] ["TOPLEFT"] = "좌측 상단",
	--[[ koKR ]] ["TOP"] = "상단",
	--[[ koKR ]] ["TOPRIGHT"] = "우측 상단",
	--[[ koKR ]] ["LEFT"] = "좌측",
	--[[ koKR ]] ["CENTER"] = "가운데",
	--[[ koKR ]] ["RIGHT"] = "우측",
	--[[ koKR ]] ["BOTTOMLEFT"] = "좌측 하단",
	--[[ koKR ]] ["BOTTOM"] = "하단",
	--[[ koKR ]] ["BOTTOMRIGHT"] = "우측 하단",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Raid Icon"] = "Рейдовый значок",
	--[[ ruRU ]] ["Raid icon placement options"] = "Настройки положения рейдового значка",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Enable raid icon display on the nameplate"] = "Включить рейдовый значок на табличке",
	--[[ ruRU ]] ["Size"] = "Размер",
	--[[ ruRU ]] ["Size in pixels of the raid icon"] = "Размер рейдового значка в пикселях",
	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust raid icon position"] = "Задать место рейдового значка",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the raid icon"] = "Смещение рейдового значка по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the raid icon"] = "Смещение рейдового значка по Y",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the raid icon"] = "Задает прикрепление рейдового значка",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the raid icon"] = "Задает точку для положения рейдового значка относительно полоски здоровья",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the raid icon alpha"] = "Задает прозрачность рейдового значка",

	--[[ ruRU ]] ["TOPLEFT"] = "ВВЕРХУ-СЛЕВА",
	--[[ ruRU ]] ["TOP"] = "ВВЕРХУ",
	--[[ ruRU ]] ["TOPRIGHT"] = "ВВЕРХУ-СПРАВА",
	--[[ ruRU ]] ["LEFT"] = "СЛЕВА",
	--[[ ruRU ]] ["CENTER"] = "ПО ЦЕНТРУ",
	--[[ ruRU ]] ["RIGHT"] = "СПРАВА",
	--[[ ruRU ]] ["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА",
	--[[ ruRU ]] ["BOTTOM"] = "СНИЗУ",
	--[[ ruRU ]] ["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Raid Icon"] = "团队图标",
	--[[ zhCN ]] ["Raid icon placement options"] = "团队图标位置相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Enable raid icon display on the nameplate"] = "在姓名板上显示团队图标",
	--[[ zhCN ]] ["Size"] = "尺寸",
	--[[ zhCN ]] ["Size in pixels of the raid icon"] = "以像素定义的团队图标尺寸",
	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust raid icon position"] = "调整团队图标的位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the raid icon"] = "团队图标的X轴偏移量",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the raid icon"] = "团队图标的Y轴偏移量",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the raid icon"] = "设定团队图标的锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the raid icon"] = "设定团队图标固定在生命值显示条的相对位置",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the raid icon alpha"] = "设定团队图标的透明度",

	--[[ zhCN ]] ["TOPLEFT"] = "左上",
	--[[ zhCN ]] ["TOP"] = "上",
	--[[ zhCN ]] ["TOPRIGHT"] = "右上",
	--[[ zhCN ]] ["LEFT"] = "左",
	--[[ zhCN ]] ["CENTER"] = "中",
	--[[ zhCN ]] ["RIGHT"] = "右",
	--[[ zhCN ]] ["BOTTOMLEFT"] = "左下",
	--[[ zhCN ]] ["BOTTOM"] = "下",
	--[[ zhCN ]] ["BOTTOMRIGHT"] = "右下",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Raid Icon"] = "團隊圖示",
	--[[ zhTW ]] ["Raid icon placement options"] = "團隊圖示佈局選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Enable raid icon display on the nameplate"] = "在名牌顯示團隊圖示",
	--[[ zhTW ]] ["Size"] = "大小",
	--[[ zhTW ]] ["Size in pixels of the raid icon"] = "團隊圖示大小",
	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust raid icon position"] = "團隊圖示位置",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the raid icon"] = "團隊圖示X位移",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the raid icon"] = "團隊圖示Y位移",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the raid icon"] = "團隊圖示定位點",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the health bar to anchor the raid icon"] = "團隊圖示固定在生命力條的位置",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the raid icon alpha"] = "團隊圖示透明度",

	--[[ zhTW ]] ["TOPLEFT"] = "左上",
	--[[ zhTW ]] ["TOP"] = "上",
	--[[ zhTW ]] ["TOPRIGHT"] = "右上",
	--[[ zhTW ]] ["LEFT"] = "左",
	--[[ zhTW ]] ["CENTER"] = "中",
	--[[ zhTW ]] ["RIGHT"] = "右",
	--[[ zhTW ]] ["BOTTOMLEFT"] = "左下",
	--[[ zhTW ]] ["BOTTOM"] = "下",
	--[[ zhTW ]] ["BOTTOMRIGHT"] = "右下",
} end)

-----------------------------------------------------------------------------

end
