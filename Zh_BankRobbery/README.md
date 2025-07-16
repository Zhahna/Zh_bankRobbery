# ND_BankRobbery

Requirements
Andyyy Framework
https://github.com/ND-Framework/ND_Framework

Andyyy ModernHud
https://andyyy.tebex.io/category/fivem-scripts

Mythic Prog_bar
https://github.com/HalCroves/mythic_progbar


Modify the server.lua to update the costs of payouts.

``RegisterServerEvent("GiveRewardBank", function()
	local player = source
	NDCore.Functions.AddMoney(20000, player, "cash")
end)``
