function A()
	if f<2 then
		gg.clearList()
		gg.clearResults()
		gg.setRanges(gg.REGION_C_HEAP|gg.REGION_C_ALLOC)
		w=0
		for j=0,9 do
			if j<1 then
				p=gg.prompt({'Tempo attuale (s)','Tempo obiettivo (ms opzionali)'},{n,t},{'number','number'})
				if not p or not tonumber(p[1]) or not tonumber(p[2]) or p[1]+0<9 or p[2]+0<9 or p[2]+0>180 then
					gg.toast('Annullato')
					return
				end
				n,t=p[1]+0,p[2]+0
			end
			x=(n-1)*1000000
			y=x+2000000
			x=x..'~'..y
			if j<1 then
				gg.searchNumber(x,gg.TYPE_DWORD)
			else
				gg.refineNumber(x,gg.TYPE_DWORD)
			end
			v=gg.getResultsCount()
			if w==v or j>8 then
				n=n-j
				break
			else
				w=v
				gg.toast(v)
				n=n+1
				gg.sleep(1000)
			end
		end
		if v<1 or v>50 then
			z={}
			gg.toast('Errore '..v..' valori')
		else
			z=gg.getResults(v)
			gg.toast('Bloccato')
			f=2
		end
	else
		p=gg.prompt({'Tempo obiettivo (ms opzionali)'},{t},{'number'})
		if not p or not tonumber(p[1]) or p[1]+0<9 or p[1]+0>180 then
			gg.toast('Annullato')
			return
		end
		t=p[1]+0
		z=gg.getListItems()
		gg.toast('Modificato')
	end
	if t==math.floor(t) then
		r='0.'..math.random(1,750)
		t=t+r
	end
	for _,u in ipairs(z) do
		u.value=t*1000000
		u.freeze=true
	end
	t=math.floor(t)
	gg.addListItems(z)
end
function B()
	if f<2 then
		p=gg.prompt({"Valore [25;100]","Non chiedere più"},{m*100,false},{'number','checkbox'})
		if not p then
			gg.toast('Annullato')
			return
		end
		m=p[1]..'.0'
		m=m/100
		a=1
		if p[2]==true then
			b=1
			gg.toast('Pronto per INFINITE gare')
		else
			gg.toast('Pronto per UNA gara')
		end
	else
		for _,u in ipairs(gg.getListItems()) do
			u.freeze=false
		end
		gg.clearList()
		gg.clearResults()
		gg.toast('Sbloccato')
		f=1
	end
end
function C()
	gg.setVisible(true)
	os.exit()
end
f,a,b,g=1,0,0,loadfile(gg.EXT_STORAGE..'/a')
if g~=nil then
	m,n,t=g()[1],g()[2],g()[3]
else
	m,n,t=0.3,0,0
end
while 1 do
	if gg.isVisible() then
		gg.setVisible(false)
		if a<1 and b<1 then
			i,o={{'Tempo','Accelerazione/derapata','Esci'},{'Modifica rapida','Sblocca'}},{A,B,C}
			c=gg.choice(i[f])
			if c then
				o[c]()
			end
		else
			gg.clearResults()
			gg.setRanges(gg.REGION_C_ALLOC)
			gg.searchNumber('0.23~0.27;-0.0006~0;-0.0006~0;0.3::13',gg.TYPE_FLOAT)
			gg.refineNumber('0.23~0.27',gg.TYPE_FLOAT)
			gg.getResults(gg.getResultsCount())
			z=gg.editAll(m,gg.TYPE_FLOAT)
			gg.toast('Modificati '..z..' valori')
			a=0
			gg.clearResults()
		end
		gg.saveVariable({m,n,t},gg.EXT_STORAGE..'/a')
	end
end
