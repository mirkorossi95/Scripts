c = gg.makeRequest("https://raw.githubusercontent.com/mirkorossi95/Scripts/master/com.gameloft.android.ANMP.GloftA9HM.lua").content
if c then
	pcall(load(c))
end