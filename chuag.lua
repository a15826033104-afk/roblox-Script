local G={mLgvm=string,VDLoz=table,zCZob=game,Eykza=tonumber,kURbl=math,GdwfY=pcall,iXxhM=
type,zvwjx=isfile,dnqDx=readfile,YvxLf=writefile,Wtfkd=isfolder,OqiMj=makefolder,pvkJA=
pairs,HkvmT=os,UjcQq=Instance,oHgEP=Enum,smHtU=workspace,JAIcf=Vector2,KKAnN=Color3,RGctw=
UDim2,eVkGt=UDim,DkTPT=tostring,mfAgK=task,uWcTr=ipairs,cZzis=loadstring,kiSsj=error,mzALM
=print,DLXJN=getgenv,eZykJ=collectgarbage,HchIF=Vector3,pVqak=warn,yweLq=coroutine,TgxHm=
setmetatable,WcCRE=TweenInfo,MIxZx=Rect,mFaya=typeof,NfHmk=require,fzYWz=CFrame,xBAGX=
ColorSequence,NYLma=ColorSequenceKeypoint,UyIZz=NumberSequence,beFsD=
NumberSequenceKeypoint,BqUzY=OverlapParams,DhOIi=firetouchinterest,Xbsrm=getrawmetatable,
grqRe=setreadonly,tawnN=newcclosure,OHADh=getnamecallmethod,JANoZ=version,qbiKc=Font,uZbGJ
=setclipboard,qgLIj=delfile,llVRo=identifyexecutor};local fca0a1={223,212,144,84,3,39,230,
113};local function e7fb1(_enc)local _out={};for _i=1,#_enc do local _k=fca0a1[((_i-1)%#
fca0a1)+1];local _b=G["mLgvm"].byte(_enc,_i);local _x=_b;if _b>=_k then _x=_b-_k else _x=
_b+(256-_k)end;_out[_i]=G["mLgvm"].char(_x%256)end;return G["VDLoz"].concat(_out)end;local
d31cc4e681=G["zCZob"]:GetService(e7fb1("/@\241\205h\153Y"));local c78967479=G["zCZob"]:
GetService(e7fb1("2H\241\198w\140X\184T="));local e765953e=d31cc4e681.LocalPlayer;local
b653ef5cf8=e7fb1("\"<\249\183n\140T\179D5\243\188F\143O\212J9\254\168h\138N\208#5\004\181"
);local cf6452=b653ef5cf8..e7fb1("\014I\249\179f\141M\159SL\004");local ebc1bb4=b653ef5cf8..
e7fb1("\014H\248\185p\140\020\229WH");local fb214={};local e5be2=false;local bc26260545=
e7fb1("+=\247\188w");local e212923d={[e7fb1("+=\247\188w")]=true,[e7fb1("0I\249\185wG2\218F<\004"
)]=true,[e7fb1("85\002\201")]=true,[e7fb1("2C\252\181u\144`\214C\244\220\189j\143Z")]=true
,[e7fb1("!5\252\192r\150T")]=true,[e7fb1("2C\246\200F\153K\210L")]=true,[e7fb1("\"@\255\201g"
)]=true};local fe5cb={[e7fb1("0I\249\185wG2\218F<\004")]=e7fb1("+=\247\188w"),[e7fb1("85\002\201"
)]=e7fb1("2C\246\200F\153K\210L"),[e7fb1("2C\252\181u\144`\214C\244\220\189j\143Z")]=e7fb1("+=\247\188w"
),[e7fb1(" 6\t\199v")]=e7fb1(",=\244\194l\142N\229"),[e7fb1(" F\243tG\136X\220")]=e7fb1("#5\002\191"
),[e7fb1("3C\253\195u\153U\232\255\"\249\187k\155\006\179KI\245")]=e7fb1(".7\245\181q"),[
e7fb1(",C\254\195n\136O")]=e7fb1("#5\002\191"),[e7fb1(" A\245\200k\160Y\229\255\024\241\198n"
)]=e7fb1(" A\245\200k\160Y\229")};local function a48492e5(ad2b0e)local ca9f9=G["Eykza"](
ad2b0e);return ca9f9 and G["kURbl"].floor(ca9f9)or nil end;G["GdwfY"](function()if G["iXxhM"
](G["zvwjx"])==e7fb1("EI\254\183w\144U\223")and G["iXxhM"](G["dnqDx"])==e7fb1("EI\254\183w\144U\223"
)then if G["zvwjx"](cf6452)then for e79f3,b2c25e in G["mLgvm"].gmatch(G["dnqDx"](cf6452),
e7fb1("\007/\181\203b\132\017\154\004G\186\145(\154\016\153:\249\189ygL\020\206\n\253"))do
fb214[e79f3]=a48492e5(b2c25e)end end;if G["zvwjx"](ebc1bb4)then local ca9c6dd=G["dnqDx"](
ebc1bb4);if G["iXxhM"](ca9c6dd)==e7fb1("RH\002\189q\142")then local e21c52c6af=ca9c6dd:
match(e7fb1("=\249\003~+U\019\154\004G\186x"));if e21c52c6af==e7fb1("K=\247\188w")then
e21c52c6af=e7fb1("+=\247\188w")elseif e21c52c6af==e7fb1("C5\002\191")then e21c52c6af=e7fb1("#5\002\191"
)end;if e21c52c6af~=e7fb1("")then bc26260545=e21c52c6af;e5be2=not e212923d[e21c52c6af]end
end end end end);local function b48d02a()G["GdwfY"](function()if G["iXxhM"](G["YvxLf"])~=
e7fb1("EI\254\183w\144U\223")then return end;if G["iXxhM"](G["Wtfkd"])==e7fb1("EI\254\183w\144U\223"
)and G["iXxhM"](G["OqiMj"])==e7fb1("EI\254\183w\144U\223")and not G["Wtfkd"](b653ef5cf8)
then G["OqiMj"](b653ef5cf8)end;local fbd8e03b79={};for a4a34f3,e0c12cb6 in G["pvkJA"](
fb214)do if G["iXxhM"](e0c12cb6)==e7fb1("MI\253\182h\153")then fbd8e03b79[#fbd8e03b79+1]=G["mLgvm"
].format(e7fb1("\004G\205yg"),a4a34f3,G["kURbl"].floor(e0c12cb6))end end;G["VDLoz"].sort(
fbd8e03b79);G["YvxLf"](cf6452,G["VDLoz"].concat(fbd8e03b79,e7fb1("\011")))end)end;local
function ddb8852(b4bc135785,a0705a47f)b4bc135785,a0705a47f=G["kURbl"].floor(b4bc135785 or 0
),G["kURbl"].floor(a0705a47f or 0);if b4bc135785<200 or a0705a47f<150 then return end;if G["kURbl"
].abs((fb214.w or 0)-b4bc135785)<=1 and G["kURbl"].abs((fb214.h or 0)-a0705a47f)<=1 then
return end;fb214.w,fb214.h=b4bc135785,a0705a47f;b48d02a()end;local a7150cb=G["HkvmT"].
clock();local dc9ee79={done=false};do local a577d4=e765953e:FindFirstChild(e7fb1("/@\241\205h\153-\230H"
));if not a577d4 then G["GdwfY"](function()a577d4=e765953e:WaitForChild(e7fb1("/@\241\205h\153-\230H"
),5)end)end;if not a577d4 then G["GdwfY"](function()a577d4=G["zCZob"]:GetService(e7fb1("\"C\002\185J\156O"
))end)end;local fdc6d=G["UjcQq"].new(e7fb1("27\002\185h\149-\230H"));fdc6d.Name=e7fb1("\"<\005\181q\142(\224NH"
);fdc6d.ResetOnSpawn=false;fdc6d.IgnoreGuiInset=true;fdc6d.DisplayOrder=99999999;G["GdwfY"
](function()fdc6d.ZIndexBehavior=G["oHgEP"].ZIndexBehavior.Sibling end);dc9ee79.Gui=fdc6d;
local f6a6af26=(G["smHtU"].CurrentCamera and G["smHtU"].CurrentCamera.ViewportSize)or G["JAIcf"
].new(1280,720);local c839b3=G["kURbl"].clamp(G["kURbl"].floor(f6a6af26.X*0.64),236,392);
local a8bbb10a=G["kURbl"].clamp(G["kURbl"].floor(c839b3*0.4),88,122);local c68f2e137=e5be2
and G["KKAnN"].fromRGB(26,27,33)or G["KKAnN"].fromRGB(250,250,252);local acfed344=e5be2 and
G["KKAnN"].fromRGB(60,64,78)or G["KKAnN"].fromRGB(206,210,222);local dc5bd=e5be2 and G["KKAnN"
].fromRGB(242,243,248)or G["KKAnN"].fromRGB(26,27,33);local c28118c4=e5be2 and G["KKAnN"].
fromRGB(150,156,172)or G["KKAnN"].fromRGB(110,116,132);local b5238b375=e5be2 and G["KKAnN"
].fromRGB(44,46,56)or G["KKAnN"].fromRGB(226,229,238);local a57c2c68e=G["UjcQq"].new(e7fb1("%F\241\193h"
));a57c2c68e.Name=e7fb1("\"5\002\184");a57c2c68e.AnchorPoint=G["JAIcf"].new(0.5,0.5);
a57c2c68e.Position=G["RGctw"].fromScale(0.5,0.42);a57c2c68e.Size=G["RGctw"].fromOffset(
c839b3,a8bbb10a);a57c2c68e.BackgroundColor3=c68f2e137;a57c2c68e.BorderSizePixel=0;
a57c2c68e.Parent=fdc6d;local fe126=G["UjcQq"].new(e7fb1("4\029\211\195u\149K\227"));fe126.
CornerRadius=G["eVkGt"].new(0,14);fe126.Parent=a57c2c68e;local cad452e40b=G["UjcQq"].new(
e7fb1("4\029\227\200u\150Q\214"));cad452e40b.Thickness=1;cad452e40b.Color=acfed344;
cad452e40b.Transparency=0.4;cad452e40b.Parent=a57c2c68e;local d842724=G["UjcQq"].new(e7fb1("%F\241\193h"
));d842724.Name=e7fb1("#C\004");d842724.Size=G["RGctw"].fromOffset(8,8);d842724.Position=G["RGctw"
].fromOffset(16,18);d842724.BackgroundColor3=G["KKAnN"].fromRGB(76,194,255);d842724.
BorderSizePixel=0;d842724.Parent=a57c2c68e;local a08a1e=G["UjcQq"].new(e7fb1("4\029\211\195u\149K\227"
));a08a1e.CornerRadius=G["eVkGt"].new(1,0);a08a1e.Parent=d842724;local a0fc580=G["UjcQq"].
new(e7fb1("39\008\200O\136H\214K"));a0fc580.Name=e7fb1("3=\004\192h");a0fc580.Size=G["RGctw"
].new(1,-40,0,18);a0fc580.Position=G["RGctw"].fromOffset(30,14);a0fc580.
BackgroundTransparency=1;a0fc580.Text=e7fb1("\196\\F8\192\195\206\245y\186,\000+\014\144\008\008"
);a0fc580.TextColor3=dc5bd;a0fc580.TextSize=15;a0fc580.Font=G["oHgEP"].Font.GothamBold;
a0fc580.TextXAlignment=G["oHgEP"].TextXAlignment.Left;a0fc580.Parent=a57c2c68e;local
ef8108d=G["UjcQq"].new(e7fb1("39\008\200O\136H\214K"));ef8108d.Name=e7fb1("2H\241\200x\154"
);ef8108d.Size=G["RGctw"].new(1,-32,0,16);ef8108d.Position=G["RGctw"].fromOffset(16,36);
ef8108d.BackgroundTransparency=1;ef8108d.Text=e7fb1("\197\12939\159\207\203\001\142\185\026\252"
);ef8108d.TextColor3=c28118c4;ef8108d.TextSize=12;ef8108d.Font=G["oHgEP"].Font.Gotham;
ef8108d.TextXAlignment=G["oHgEP"].TextXAlignment.Left;ef8108d.Parent=a57c2c68e;local dbc8a5
=G["UjcQq"].new(e7fb1("%F\241\193h"));dbc8a5.Name=e7fb1("3F\241\183n");dbc8a5.Size=G["RGctw"
].new(1,-32,0,4);dbc8a5.Position=G["RGctw"].new(0,16,1,-26);dbc8a5.BackgroundColor3=
b5238b375;dbc8a5.BorderSizePixel=0;dbc8a5.Parent=a57c2c68e;local ffe21a=G["UjcQq"].new(
e7fb1("4\029\211\195u\149K\227"));ffe21a.CornerRadius=G["eVkGt"].new(1,0);ffe21a.Parent=
dbc8a5;local da24f31ffd=G["UjcQq"].new(e7fb1("%F\241\193h"));da24f31ffd.Name=e7fb1("%=\252\192"
);da24f31ffd.Size=G["RGctw"].new(0.05,0,1,0);da24f31ffd.BackgroundColor3=G["KKAnN"].
fromRGB(76,194,255);da24f31ffd.BorderSizePixel=0;da24f31ffd.Parent=dbc8a5;local db50b5=G["UjcQq"
].new(e7fb1("4\029\211\195u\149K\227"));db50b5.CornerRadius=G["eVkGt"].new(1,0);db50b5.
Parent=da24f31ffd;local bb38f=e7fb1("\197\12939\159\207\203\001\142\185\026\252");dc9ee79.
Set=function(d5ae215d81,bd5fe05)bb38f=G["DkTPT"](d5ae215d81 or e7fb1(""));ef8108d.Text=
bb38f;if bd5fe05 then da24f31ffd.Size=G["RGctw"].new(G["kURbl"].clamp(bd5fe05,0,1),0,1,0)
end end;dc9ee79.Finish=function()if dc9ee79.done then return end;dc9ee79.done=true;ef8108d.
Text=e7fb1("\198i\028=\160\201\203!\144\187K\254");da24f31ffd.Size=G["RGctw"].new(1,0,1,0)
;G["mfAgK"].delay(0.25,function()G["GdwfY"](function()fdc6d:Destroy()end)end)end;G["mfAgK"
].spawn(function()local f0cfc76654=0;while fdc6d.Parent and not dc9ee79.done do f0cfc76654
=(f0cfc76654+1)%4;ef8108d.Text=bb38f..G["mLgvm"].rep(e7fb1("\161\139"),f0cfc76654);G["mfAgK"
].wait(0.3)end end);G["GdwfY"](function()fdc6d.Parent=a577d4 end)end;G["mfAgK"].delay(8,
function()if not dc9ee79.done then G["GdwfY"](function()dc9ee79.Set(e7fb1("\195\143\0299\159\207\203\251\127\188M\017\242\227rX\156ew\015\159\012u \199WM<\193\170\204\246\129\182\016\250"
),0.55)end)end end);local a97d03=e7fb1("\"<\249\183n\140T\179D5\243\188F\143O\212J9\254\168h\138N\208#5\004\181"
);local f9dfb19=a97d03..e7fb1("\014:\000\179f\136I\217D\002\252\201d\156");local d9591ef7={
Tag=e7fb1("!9\004\181CY\022\163\021\001\193\1330Y\024"),Bytes=289640,Marker=e7fb1("%@\005\185q\1556\221TG"
)};local d8881=e7fb1("");local d872b6d3={e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\244\189v\138U\210QH\191\154o\156K\223S$\252\201vVX\214EG\191\188h\136J\228\014A\241\189qV(\214S5\190\192x\136"
),e7fb1("GH\004\196va\021\160F<\189\196u\150^\234\r7\255\1932\143Z\229OG\202\1312\153G\232\r;\249\200k\156H\230R9\002\183r\149Z\214MH\190\183r\148\021\213HG\243\195d\153Z\160%@\005\185q\1556\221TG\191\198h\141Y\160G9\241\184vVS\210HB\191\150h\155G\159KI\241"
),e7fb1("GH\004\196va\021\160F<\246\181v\155\020\229ND\191\188w\155V\228\025\003\191\198d\158\020\216HH\248\201e\156Y\214Q7\255\194w\140T\229\r7\255\1932\139O\228BC\241\198wV,\221T9\254\200S\147[\228\014F\245\186vVN\214@8\003\131p\136O\223\014\022\245\200dUR\230@"
)};local f61e84a76={};if d8881~=e7fb1("")then G["VDLoz"].insert(f61e84a76,d8881)end;for
ae5136fa4,bd6fa in G["uWcTr"](d872b6d3)do G["VDLoz"].insert(f61e84a76,bd6fa)end;if G["iXxhM"
](G["Wtfkd"])==e7fb1("EI\254\183w\144U\223")and G["iXxhM"](G["OqiMj"])==e7fb1("EI\254\183w\144U\223"
)then G["GdwfY"](function()if not G["Wtfkd"](a97d03)then G["OqiMj"](a97d03)end end)end;
local function a5335d3(b36f6b74a)local a9aefc=0;local function a82259f9f(b65d04c,d34ead)
local d066f5a4=G["mLgvm"].find(b36f6b74a,b65d04c,1,true);if d066f5a4 then b36f6b74a=G["mLgvm"
].sub(b36f6b74a,1,d066f5a4-1)..d34ead..G["mLgvm"].sub(b36f6b74a,d066f5a4+#b65d04c);a9aefc=
a9aefc+1 end end;a82259f9f(e7fb1("KC\243\181oG8\214R=\n\189q\142\018\14519\003\189}\1406\224R\244\205ti\136R\228D"
),e7fb1("KC\243\181oG8\214R=\n\189q\142\018\14519\003\189}\1406\224R\000\176\166h\154O\235D'\004\181u\1559\218Y9\176\145#\141G\221R9\188tq\144R\157\255B\249\192"
));a82259f9f(e7fb1("\232\221\153]U\140Y\218Y=\254\187#d\006\229QI\245^\0120\239z19\003\189}\1406\224R\244\205tL\149V\230S\002\224\195v\144Z\218NB"
),e7fb1("\232\221\153]U\140Y\218Y=\254\187#d\006\229QI\245^\0120\239z19\003\189}\1406\224R\244\205tL\149V\230S\002\224\195v\144Z\218NB\154]\0120\239\195DG\249\206hzZ\210QH\227\189}\140\006\174\255+\249\194g\150]\1592=\n\185"
));a82259f9f(e7fb1("KC\243\181oG9\229@F\004\167l\161K\145\028\244\231\189q\139U\232\r'\249\206h"
),e7fb1("KC\243\181oG9\229@F\004\167l\161K\145\028\244\226\185v\144`\2142H\241\198wzO\235D\244\255\198#~O\223CC\007\130V\144`\214"
));a82259f9f(e7fb1("L5\004\1881\138R\210LD\184\168d\153M\214S'\249\206hU>\157\255\008\199\132/G\024\161\019\012\185\128#\148G\229G\002\243\192d\148V\15335\002\187h\1559\218Y9\190\173/G\025\169\015\000\176\1343[\030\154"
),e7fb1("L5\004\1881\138R\210LD\184\168d\153M\214S'\249\206hU>\157\255\007\192\132/G\024\161\019\012\185\128#\148G\229G\002\243\192d\148V\15335\002\187h\1559\218Y9\190\173/G\024\165\015\000\176\1343[\030\154"
));a82259f9f(e7fb1("H:\176\166h\154O\235HB\247t@d\006\229QI\245tr\153\006\186MD\005\2001|Y\214Q\029\254\196x\155:\234O9\176\145@G+\223TA\190\169v\140X\186MD\005\200W\160V\214\r(\255\201f\143\006\229G9\254"
),e7fb1("H:\176\166h\154O\235HB\247t@d\006\229QI\245tw\143K\223"));a82259f9f(e7fb1("#=\241\192r\142\020\195NC\004\130V\144`\214\255\017\176\169G\144S\163\r:\002\195pvL\215R9\004|7Z\022\157\255\007\195\132,"
),e7fb1("KC\243\181oGE\231O\244\205tF\136S\214Q5\190\170l\140]\225NF\004\167l\161K{\232\221\153]o\150I\210K\244\239\184zG#\145L5\004\1881\148O\223\007\008\195\132/GE\231O\002\232t0G\023\167\008\222\153]\0120R\224B5\252tb\139N\145\028\244\253\181w\143\020\222HB\184\1356W\018\145>J\000\130\\G\019\145\016\005\192}\r0\239z\232\024\249\181o\150M\1591C\255\2001zO\235D\244\205tXkO\222\017\002\246\198r\1485\215EG\245\200+\134J\232\011\244\239\184kP\240z\232\221\153\189iGE\213V\244\204t7Z\022\145NF\176\179g\143\006\173\255\007\195\132#\155N\214M\222\153]\0120\239\221N7\241\192#\134Y\212\255\017\176\157q\154Z\210M7\245\130q\140]\153\001)\217\167f\136R\214\001\253\154]\0120\239z>G\243\130V\138G\221D\244\205tp\136Z\217\rA\249\194+\134J\232\255\003\176\1366W\018\145>8\248t2G\025\164\015\253\154]\0120\239z>G\243\130S\136X\214MH\176\145#kO\210KC\247\130U\150U\229\233\221\153]\012\140T\213"
));a82259f9f(e7fb1(" F\245t|\150[\145RI\002\185#\160U\230\255K\241\194wGZ\224\255I\254\192r\136J\145S<\245tl\149Z\214Q:\241\183hf"
),e7fb1("\198u>9\177\193\206\023`\185\021\007\236\190\147Xt`y\241\165\012v\008\206\144/"))
;a82259f9f(e7fb1("3=\004\192hG#\145\001\023\252\195v\140\008"),e7fb1("3=\004\192hG#\145\001\185\021\007\236\190\147\147"
));a82259f9f(e7fb1("3=\004\192hG#\145\001-\245\199%"),e7fb1("3=\004\192hG#\145\001\186(\003%"
));a82259f9f(e7fb1("3=\004\192hG#\145\001\"\255v"),e7fb1("3=\004\192hG#\145\001\185 \250%"
));return b36f6b74a,a9aefc end;local function fdf3018dc(f60575)if G["iXxhM"](f60575)~=
e7fb1("RH\002\189q\142")or#f60575<200000 then return false end;if not G["mLgvm"].find(
f60575,e7fb1("19\003\189}\1409\229@F\004\167l\161K"),1,true)then return false end;if not G["mLgvm"
].find(f60575,e7fb1("L5\004\1881\138R\210LD\184\168d\153M\214S'\249\206hU>\157\255\007\192\132/G\024\161\019\012\185"
),1,true)then return false end;if not G["mLgvm"].find(f60575,e7fb1("\198u>9\177\193\206\023`\185\021\007\236\190\147Xt`y\241\165\012v\008\206\144/"
),1,true)then return false end;return true end;local ecaa2c4;local c5f0ec02a0;if G["iXxhM"
](G["zvwjx"])==e7fb1("EI\254\183w\144U\223")and G["iXxhM"](G["dnqDx"])==e7fb1("EI\254\183w\144U\223"
)then local b5fb9c60,c26c2d2=G["GdwfY"](function()if G["zvwjx"](f9dfb19)then return G["dnqDx"
](f9dfb19)end end);if b5fb9c60 and fdf3018dc(c26c2d2)then local adf3f8e,e9ca2b3980=G["GdwfY"
](function()return G["cZzis"](c26c2d2)()end);if adf3f8e and e9ca2b3980 then ecaa2c4=
e9ca2b3980;c5f0ec02a0=e7fb1("\197p<9\159\215\205-r\185=\236")end end end;if not ecaa2c4
then local e77cf1={};for ac83f341,dd596642 in G["uWcTr"](f61e84a76)do local b7e0ba,
eaaff7d4d3=G["GdwfY"](function()return G["zCZob"]:HttpGet(dd596642,true)end);if b7e0ba and
G["iXxhM"](eaaff7d4d3)==e7fb1("RH\002\189q\142")and#eaaff7d4d3>200000 then local b144f65682
,cbac616=eaaff7d4d3,10;if not fdf3018dc(eaaff7d4d3)then b144f65682,cbac616=a5335d3(
eaaff7d4d3)end;if cbac616<10 then e77cf1[#e77cf1+1]=e7fb1("\199u58\187\168\203\002\156\184H\001#"
)..G["DkTPT"](cbac616)..e7fb1("\014\005\192")end;if fdf3018dc(b144f65682)then local a95ceb9
,c35b9196c5=G["GdwfY"](function()return G["cZzis"](b144f65682)()end);if a95ceb9 and
c35b9196c5 then ecaa2c4=c35b9196c5;c5f0ec02a0=dd596642:match(e7fb1("=<\004\200s\154%\171\014\003\184\175aVC\156\008"
))or e7fb1("\200i,9\134\182");G["GdwfY"](function()if G["iXxhM"](G["YvxLf"])==e7fb1("EI\254\183w\144U\223"
)then G["YvxLf"](f9dfb19,b144f65682)end end);break end;e77cf1[#e77cf1+1]=e7fb1("KC\241\184v\155X\218M;\1769\167\216\206%\132"
)else e77cf1[#e77cf1+1]=e7fb1("\199u58\187\168\203\001m\1860\245\236\209rV\131\133x\008\168"
)end else e77cf1[#e77cf1+1]=e7fb1("\196c&8\187\180\203\249\143\244")..(dd596642:match(
e7fb1("=<\004\200s\154%\171\014\003\184\175aVC\156\008"))or dd596642)end end;if not ecaa2c4
then G["kiSsj"](e7fb1("%@\005\185q\1556\221TG\1769\141\199\206.\156\1854\005\235\219\139`\155n"
)..G["VDLoz"].concat(e77cf1,e7fb1("\206\144+")),0)end end;G["GdwfY"](function()dc9ee79.Set(
e7fb1("%@\005\185q\1556\221TG\1769\186\217\203!\144\187K\254"),0.32)end);G["mzALM"](e7fb1(":\185\024\218\233\187\149\206\255\026\252\201h\149Z\193KI\003t\232\177\134Y\156\145v\220\147\012p\016\255\182\022\228#"
)..G["DkTPT"](c5f0ec02a0));local ffa92b=G["HkvmT"].clock();G["GdwfY"](function()dc9ee79.
Set(e7fb1("\197\140\021;\147\173\202)i\184H\212\235\228\148W\141_w\233\156"),0.4)end);do
local cdb69ccd8=G["zCZob"]:GetService(e7fb1("\"C\002\185J\156O"));local cfa400=e765953e:
WaitForChild(e7fb1("/@\241\205h\153-\230H"));local a2ded72=G["DLXJN"]().ChuangThreads;if G["iXxhM"
](a2ded72)==e7fb1("S5\242\192h")then for ff3c569d=#a2ded72,1,-1 do G["GdwfY"](G["mfAgK"].
cancel,a2ded72[ff3c569d]);a2ded72[ff3c569d]=nil end end;local da8c479=G["DLXJN"]().
ChuangState;if G["iXxhM"](da8c479)==e7fb1("S5\242\192h")then for abee64,aa9f1d06 in G["pvkJA"
](da8c479)do if G["iXxhM"](aa9f1d06)==e7fb1("AC\255\192h\136T")then da8c479[abee64]=false
end end end;local d23982b9d5=G["DLXJN"]().Chuang;if G["iXxhM"](d23982b9d5)==e7fb1("S5\242\192h"
)then G["GdwfY"](function()d23982b9d5.Shutdown()end)end;for b45ce86b,d44d637573 in G["uWcTr"
]({cdb69ccd8,cfa400})do for a309dfb55,e25058ad6 in G["uWcTr"](d44d637573:GetChildren())do
if e25058ad6:IsA(e7fb1("27\002\185h\149-\230H"))and e25058ad6~=dc9ee79.Gui and(e25058ad6.
Name:find(e7fb1("%@\005\185q\155"),1,true)or e25058ad6.Name:find(e7fb1("\"<\005\181q\142")
,1,true)or e25058ad6.Name:find(e7fb1("\198~'"),1,true))then e25058ad6:Destroy()end end end
;G["GdwfY"](function()local b1dbeadd2=G["zCZob"]:GetService(e7fb1("+=\247\188w\144T\216"))
;local e835e=b1dbeadd2:FindFirstChild(e7fb1("\"<\005\181q\142'\212QM\252\189fiR\230Q"));if
e835e then e835e:Destroy()end end);local b7fcb825a3=e765953e.Character;if b7fcb825a3 then
for dc9f21ac7,dce84f in G["uWcTr"](b7fcb825a3:GetDescendants())do if(dce84f.Name==e7fb1("\"<\005\181q\142:\227@=\252"
)and dce84f:IsA(e7fb1("3F\241\189o")))or dce84f.Name==e7fb1("\"<\005\181q\142,\221X*\245\192"
)or dce84f.Name==e7fb1("\"<\005\181q\142,\221X\027\t\198r")or dce84f.Name==e7fb1("$D\249\204Y\140R"
)then G["GdwfY"](function()dce84f:Destroy()end)end end end;G["GdwfY"](function()G["eZykJ"](
);G["eZykJ"]()end);if b7fcb825a3 then local fa5f1=b7fcb825a3:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"
));for ce4ee519,fee877ae in G["uWcTr"](b7fcb825a3:GetDescendants())do if fee877ae:IsA(
e7fb1("!5\003\185S\136X\229"))then if fee877ae.Name~=e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"
)then G["GdwfY"](function()fee877ae.CanCollide=true end)end;G["GdwfY"](function()fee877ae.
AssemblyLinearVelocity=G["HchIF"].zero;fee877ae.AssemblyAngularVelocity=G["HchIF"].zero end
)end end;G["GdwfY"](function()for f31bd193,d7aba in G["uWcTr"](b7fcb825a3:GetChildren())do
if d7aba:IsA(e7fb1("!C\244\205Y\140R\224B=\004\205"))or d7aba:IsA(e7fb1("!C\244\205J\160X\224"
))then d7aba:Destroy()end end end);if fa5f1 then G["GdwfY"](function()fa5f1.WalkSpeed=G["DLXJN"
]().ChuangBaseSpeed or fa5f1.WalkSpeed;if fa5f1.Health>0 then fa5f1.Health=fa5f1.MaxHealth
end end)end;G["mfAgK"].delay(0.35,function()G["GdwfY"](function()if e765953e.Character~=
b7fcb825a3 then return end;local d7727=b7fcb825a3:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"
));if not d7727 then return end;d7727.Health=0;G["mfAgK"].wait(0.15);if d7727.Parent and
d7727.Health>0 then b7fcb825a3:BreakJoints()end end)end)end end;if G["HkvmT"].clock()-
ffa92b>1 then G["pVqak"](G["mLgvm"].format(e7fb1(":\187:\235`G\203\001\142\185\026\252\233\223kXoZx\212\154\r}'\255\249\190\134i\154\213-g\188F\217\235\230m\145\016\244w\251\149\022\162\250"
),G["HkvmT"].clock()-ffa92b))else dc9ee79.Set(e7fb1("\197\140\021;\147\173\203\031k\186\024\228\242\227rW\140wu\240\171\012\161+\198i\028=\160\201"
),0.55);G["mzALM"](G["mLgvm"].format(e7fb1(":\187:\235`G\203\001\142\185\026\252\233\223kXoZu\002\143\rn\001\255\249\190\135i\154"
),G["HkvmT"].clock()-ffa92b))end;local ce268ce4d=G["zCZob"]:GetService(e7fb1("4G\245\198L\149V\230S'\245\198y\144I\214"
));local a92302b783=G["zCZob"]:GetService(e7fb1("3K\245\185qzK\227U=\243\185"));local
e6a48d474=G["zCZob"]:GetService(e7fb1("&I\249\167h\153\\\218B9"));local e26cc=G["zCZob"]:
GetService(e7fb1("1I\254\167h\153\\\218B9"));local fd48f={};G["DLXJN"]().ChuangThreads=
fd48f;local function f86178(bfa87769)local cf5f1e8;cf5f1e8=G["mfAgK"].spawn(function()
local self=G["yweLq"].running();G["VDLoz"].insert(fd48f,self);bfa87769()end);return cf5f1e8
end;local a42ac1={};a42ac1.Version=e7fb1("\019\002\194\1304");a42ac1.Config={PillText=
e7fb1("\197]#9\191\167\205\006k\189-\246"),PillWidth=196,PillHeight=46,PillTopMargin=6,
PillStyle=e7fb1("K=\247\188w"),PillDraggable=true,KeepWindowPos=true,HideOriginalButton=
true,PillReact=true,PillReactRange=96,ButtonPress=true,ScrollBarThickness=6,KeyboardAvoid=
true,PillBreathe=true,PillSpring=true,TitleDrag=true,SelfResize=true};local c2a1fb={};
local aee1fd4107;local e9c7a={};local dc9fc=G["TgxHm"]({},{__mode=e7fb1("J")});local
function e3b72c97b()local e1be0=G["smHtU"].CurrentCamera;return e1be0 and e1be0.
ViewportSize or G["JAIcf"].new(1280,720)end;local function e21d8f676()local ec65dcc5f=0;G["GdwfY"
](function()ec65dcc5f=e6a48d474:GetGuiInset().Y end);return ec65dcc5f end;local function
c673dab()if ce268ce4d.TouchEnabled then return true end;local f22d65c7=e3b72c97b();return
f22d65c7.X<=900 and f22d65c7.Y<=600 end;local function d4aabb88(ec6f5)G["GdwfY"](function(
)c78967479:SetCore(e7fb1("29\254\184Q\150Z\218E=\243\181w\144U\223"),{Title=e7fb1("\198i\028=\160\201"
),Text=ec6f5,Duration=2})end)end;local b2810618;local function fe1e6becd()if b2810618 then
return b2810618 end;local a949ef,f45ce=G["GdwfY"](function()return d31cc4e681:
GetUserThumbnailAsync(e765953e.UserId,G["oHgEP"].ThumbnailType.HeadShot,G["oHgEP"].
ThumbnailSize.Size100x100)end);if a949ef then b2810618=f45ce;return f45ce end;return nil
end;local function df15c1(e317136b)local a6bd5e627=e317136b:FindFirstChildOfClass(e7fb1("4\029\227\183d\147K"
));if not a6bd5e627 then a6bd5e627=G["UjcQq"].new(e7fb1("4\029\227\183d\147K"));a6bd5e627.
Scale=1;a6bd5e627.Parent=e317136b end;return a6bd5e627 end;local function ed6301cdd(
eeda1ae,e11308a43d,d18ef5,f4191c6,c78fb3,a564a,d98b91210c)if not eeda1ae then return nil
end;local d6443d=G["WcCRE"].new(d18ef5 or 0.25,f4191c6 or G["oHgEP"].EasingStyle.Quad,
c78fb3 or G["oHgEP"].EasingDirection.Out,a564a or 0,d98b91210c or false);local a93f7=
a92302b783:Create(eeda1ae,d6443d,e11308a43d);a93f7:Play();return a93f7 end;local function
af329f7()if a42ac1.Config.PillStyle==e7fb1("K=\247\188w")then return 0.02 end;return 0.1
end;local e612cc70e={};local function aa3a3b2505(ce81da9)local b984b2=e612cc70e[ce81da9];
if not b984b2 then return end;for c2e86d8d18,d87a64 in G["uWcTr"](b984b2)do if d87a64 then
G["GdwfY"](function()d87a64:Cancel()end)end end;e612cc70e[ce81da9]=nil end;local function
e8395d(c15276c7)if not(c15276c7 and c15276c7.Parent)or not c15276c7.Visible then return end
;aa3a3b2505(c15276c7);if a42ac1.Config.PillBreathe==false then return end;local b8e45=G["WcCRE"
].new(1.35,G["oHgEP"].EasingStyle.Sine,G["oHgEP"].EasingDirection.InOut,-1,true);local
b7e57047={};local e00ca4e8=c15276c7:FindFirstChildOfClass(e7fb1("4\029\227\200u\150Q\214")
);if e00ca4e8 then e00ca4e8.Transparency=0.28;local c7ab9357ee=a92302b783:Create(e00ca4e8,
b8e45,{Transparency=0.62});c7ab9357ee:Play();b7e57047[#b7e57047+1]=c7ab9357ee end;local
e459dd745=dc9fc[c15276c7];if e459dd745 then local a074a=e459dd745:GetAttribute(e7fb1("!5\003\185W\153G\223RD\241\198h\149I\234"
))or e459dd745.ImageTransparency;local c2e7e5e=a92302b783:Create(e459dd745,b8e45,{
ImageTransparency=G["kURbl"].clamp(a074a+0.12,0,1)});c2e7e5e:Play();b7e57047[#b7e57047+1]=
c2e7e5e end;e612cc70e[c15276c7]=b7e57047 end;local function d1d16a611(d8bf5)if not d8bf5 or
not d8bf5.Parent then return end;aa3a3b2505(d8bf5);local ff530b=df15c1(d8bf5);d8bf5.
Visible=true;ed6301cdd(d8bf5,{BackgroundTransparency=1},0.16);ed6301cdd(ff530b,{Scale=0.86
},0.16,G["oHgEP"].EasingStyle.Quad,G["oHgEP"].EasingDirection.In);for f32a8fad,b1c2ba827 in
G["uWcTr"](d8bf5:GetDescendants())do if b1c2ba827:IsA(e7fb1("39\008\200O\136H\214K"))then
ed6301cdd(b1c2ba827,{TextTransparency=1},0.14)elseif b1c2ba827:IsA(e7fb1("(A\241\187hsG\211D@"
))then ed6301cdd(b1c2ba827,{ImageTransparency=1},0.14)end end;local d78a363=dc9fc[d8bf5];
if d78a363 then ed6301cdd(d78a363,{ImageTransparency=1},0.15)end;G["mfAgK"].delay(0.17,
function()if d8bf5 and d8bf5.Parent then d8bf5.Visible=false;d8bf5.BackgroundTransparency=
1;d8bf5.Rotation=0;ff530b.Scale=1;for d39527b740,f87b4 in G["uWcTr"](d8bf5:GetDescendants(
))do if f87b4:IsA(e7fb1("39\008\200O\136H\214K"))then f87b4.TextTransparency=0 elseif f87b4:
IsA(e7fb1("(A\241\187hsG\211D@"))then f87b4.ImageTransparency=0 end end;if d78a363 then
local fc55e2edf4=d78a363:GetAttribute(e7fb1("!5\003\185W\153G\223RD\241\198h\149I\234"))or
0.8;d78a363.ImageTransparency=fc55e2edf4;d78a363.Visible=false end end end)end;local
function b34cb7e43(f2c5d7)if not f2c5d7 or not f2c5d7.Parent then return end;f2c5d7.
Visible=true;f2c5d7.BackgroundTransparency=1;local beefa7961a=dc9fc[f2c5d7];if beefa7961a
then local fe906d532=e9c7a[f2c5d7];beefa7961a.Visible=true;beefa7961a.ImageTransparency=1;
if fe906d532 then fe906d532.apply()end end;local d402efd4=df15c1(f2c5d7);d402efd4.Scale=
0.62;for c70105d,d40b5e in G["uWcTr"](f2c5d7:GetDescendants())do if d40b5e:IsA(e7fb1("39\008\200O\136H\214K"
))then d40b5e.TextTransparency=1 end;if d40b5e:IsA(e7fb1("(A\241\187hsG\211D@"))then d40b5e.
ImageTransparency=1 end end;ed6301cdd(d402efd4,{Scale=1},0.42,G["oHgEP"].EasingStyle.Back,
G["oHgEP"].EasingDirection.Out);ed6301cdd(f2c5d7,{BackgroundTransparency=af329f7()},0.26,G["oHgEP"
].EasingStyle.Quad,G["oHgEP"].EasingDirection.Out);if beefa7961a then local b4d430938=
beefa7961a:GetAttribute(e7fb1("!5\003\185W\153G\223RD\241\198h\149I\234"))or 0.8;ed6301cdd(
beefa7961a,{ImageTransparency=b4d430938},0.3)end;for db3ad,ecc96b8312 in G["uWcTr"](f2c5d7:
GetDescendants())do if ecc96b8312:IsA(e7fb1("39\008\200O\136H\214K"))then ed6301cdd(
ecc96b8312,{TextTransparency=0},0.26)elseif ecc96b8312:IsA(e7fb1("(A\241\187hsG\211D@"))
then ed6301cdd(ecc96b8312,{ImageTransparency=0},0.26)end end;G["mfAgK"].delay(0.45,
function()if f2c5d7 and f2c5d7.Parent and f2c5d7.Visible then e8395d(f2c5d7)end end)end;
local function b1beefc46()a42ac1.PosGuard=(a42ac1.PosGuard or 0)+1;G["mfAgK"].defer(
function()a42ac1.PosGuard=G["kURbl"].max(0,(a42ac1.PosGuard or 1)-1)end)end;local function
e984f8(f15ad,e3e486,a5ab3f67e)if not f15ad or not f15ad.Root then return end;b1beefc46();
f15ad.Root.Position=G["RGctw"].fromOffset(G["kURbl"].floor(e3e486),G["kURbl"].floor(
a5ab3f67e));G["GdwfY"](function()f15ad.Position=f15ad.Root.Position end)end;local function
addabddcd(fb0ca,e66543d7,e20cc6676)if not fb0ca or not fb0ca.Root then return end;if a42ac1.
Config.KeepWindowPos==false then return end;a42ac1.WindowPos={X=G["kURbl"].floor(e66543d7)
,Y=G["kURbl"].floor(e20cc6676)}end;local function cfaefa69(c1763242c5)if not c1763242c5 or
not c1763242c5.Root then return end;local a53a0ca=c1763242c5.Root;local d42e7a95a=df15c1(
a53a0ca);local a4c3dc820=a53a0ca.Position;d42e7a95a.Scale=0.86;a53a0ca.Visible=true;
c1763242c5.Minimized=false;a53a0ca.Position=G["RGctw"].fromOffset(a4c3dc820.X.Offset,
a4c3dc820.Y.Offset+16);b1beefc46();G["mfAgK"].delay(0.36,function()a42ac1.PosGuard=G["kURbl"
].max(0,(a42ac1.PosGuard or 1)-1)end);ed6301cdd(d42e7a95a,{Scale=1},0.34,G["oHgEP"].
EasingStyle.Back,G["oHgEP"].EasingDirection.Out);ed6301cdd(a53a0ca,{Position=a4c3dc820},
0.3,G["oHgEP"].EasingStyle.Quint,G["oHgEP"].EasingDirection.Out)end;local function ca21e09c(
a18b2)if not a18b2 or not a18b2.Root then return end;local c248a6cfef=a18b2.Root;local
ccf5808b2=df15c1(c248a6cfef);local f18c4=c248a6cfef.Position;b1beefc46();G["mfAgK"].delay(
0.24,function()a42ac1.PosGuard=G["kURbl"].max(0,(a42ac1.PosGuard or 1)-1)end);ed6301cdd(
ccf5808b2,{Scale=0.84},0.2,G["oHgEP"].EasingStyle.Quad,G["oHgEP"].EasingDirection.In);
ed6301cdd(c248a6cfef,{Position=G["RGctw"].fromOffset(f18c4.X.Offset,f18c4.Y.Offset+14)},
0.2,G["oHgEP"].EasingStyle.Quad,G["oHgEP"].EasingDirection.In);G["mfAgK"].delay(0.21,
function()if c248a6cfef and c248a6cfef.Parent then c248a6cfef.Visible=false;c248a6cfef.
Position=f18c4;a18b2.Position=f18c4;a18b2.Minimized=true;ccf5808b2.Scale=1 end end)end;
local function e0753(c9df1a)if not c9df1a or not a42ac1.Config.ButtonPress then return end
;local function f5ec4(f5e74ce2)local b5f39d691d=f5e74ce2;for b896b=1,8 do b5f39d691d=
b5f39d691d.Parent;if not b5f39d691d then return false end;local f5228e9ea2,aad9353a5=G["GdwfY"
](function()return b5f39d691d:GetAttribute(e7fb1("\"<\005\181q\1424\224/F\245\199v"))end);
if f5228e9ea2 and aad9353a5 then return true end end;return false end;for aec45827,ed52c in
G["uWcTr"](c9df1a:GetDescendants())do if(ed52c:IsA(e7fb1("39\008\200E\156Z\229NB"))or ed52c:
IsA(e7fb1("(A\241\187hi[\229SC\254")))and not ed52c:GetAttribute(e7fb1("\"<\005\181q\1426\227DG\003"
))and not f5ec4(ed52c)and(ed52c:FindFirstChildOfClass(e7fb1("39\008\200O\136H\214K"))~=nil
)then ed52c:SetAttribute(e7fb1("\"<\005\181q\1426\227DG\003"),true);local fc1bb3d=ed52c:
FindFirstChildOfClass(e7fb1("4\029\227\183d\147K"));if not fc1bb3d then fc1bb3d=G["UjcQq"].
new(e7fb1("4\029\227\183d\147K"));fc1bb3d.Scale=1;fc1bb3d.Parent=ed52c end;local e2229b3a26
=fc1bb3d.Scale;ed52c.InputBegan:Connect(function(ac7670b62c)if a42ac1.Config.ButtonPress
and ed52c.AbsoluteSize.Y>=14 and(ac7670b62c.UserInputType==G["oHgEP"].UserInputType.
MouseButton1 or ac7670b62c.UserInputType==G["oHgEP"].UserInputType.Touch)then ed6301cdd(
fc1bb3d,{Scale=e2229b3a26*0.94},0.11,G["oHgEP"].EasingStyle.Quad,G["oHgEP"].
EasingDirection.Out)end end);ed52c.InputEnded:Connect(function(a03edc)if a42ac1.Config.
ButtonPress and(a03edc.UserInputType==G["oHgEP"].UserInputType.MouseButton1 or a03edc.
UserInputType==G["oHgEP"].UserInputType.Touch)then ed6301cdd(fc1bb3d,{Scale=e2229b3a26},
0.26,G["oHgEP"].EasingStyle.Back,G["oHgEP"].EasingDirection.Out)end end)end end end;local
function f86f6a84()if a42ac1.Config.PillStyle==e7fb1("K=\247\188w")then return G["KKAnN"].
fromRGB(250,250,252),G["KKAnN"].fromRGB(196,199,212),G["KKAnN"].fromRGB(26,26,32)end;
return G["KKAnN"].fromRGB(26,27,33),G["KKAnN"].fromRGB(70,72,86),G["KKAnN"].fromRGB(242,
242,248)end;local function e8923()if a42ac1.Config.PillStyle==e7fb1("K=\247\188w")then
return G["KKAnN"].fromRGB(168,178,200),0.9 end;return G["KKAnN"].fromRGB(0,0,0),0.52 end;
local function f05d7b()if a42ac1.Config.PillStyle==e7fb1("K=\247\188w")then return G["KKAnN"
].fromRGB(120,135,170)end;return G["KKAnN"].fromRGB(200,205,225)end;local c2711;local
function f9a007(cd6c9a)if c2711 and c2711.Parent then return c2711 end;c2711=G["UjcQq"].
new(e7fb1("27\002\185h\149-\230H"));c2711.Name=e7fb1("%@\005\185q\1553\224A=\252\185S\144R\221&I\249"
);c2711.ResetOnSpawn=false;c2711.IgnoreGuiInset=true;c2711.DisplayOrder=999999;G["GdwfY"](
function()c2711.ZIndexBehavior=G["oHgEP"].ZIndexBehavior.Sibling end);G["GdwfY"](function(
)c2711.Parent=cd6c9a end);if not c2711.Parent then G["GdwfY"](function()c2711.Parent=G["zCZob"
]:GetService(e7fb1("\"C\002\185J\156O"))end)end;if not c2711.Parent then G["GdwfY"](
function()c2711.Parent=e765953e:WaitForChild(e7fb1("/@\241\205h\153-\230H"))end)end;return
c2711 end;local function a3894b8(e4ddf,a4eeee7)local b3607a4,b6985d21,cbd8fb81=f86f6a84();
local ced4e002a9,aa76574518=a42ac1.Config.PillWidth,a42ac1.Config.PillHeight;local
c5bc163019=G["UjcQq"].new(e7fb1("%F\241\193h"));c5bc163019.Name=e7fb1("%@\005\185q\1553\224A=\252\185S\144R\221"
);c5bc163019.AnchorPoint=G["JAIcf"].new(0,0);c5bc163019.Size=G["RGctw"].fromOffset(
ced4e002a9,aa76574518);local aaeba7=e3b72c97b();local dbc796e5=e21d8f676();local d7867df73
=G["kURbl"].floor(aaeba7.X/2-ced4e002a9/2);local e5dba=G["kURbl"].floor(dbc796e5+a42ac1.
Config.PillTopMargin);if a42ac1.Config.PillX and a42ac1.Config.PillY then d7867df73,e5dba=
a42ac1.Config.PillX,a42ac1.Config.PillY end;c5bc163019.Position=G["RGctw"].fromOffset(
d7867df73,e5dba);c5bc163019.BackgroundColor3=b3607a4;c5bc163019.BackgroundTransparency=1;
c5bc163019.BorderSizePixel=0;c5bc163019.Visible=false;c5bc163019.ZIndex=40;c5bc163019.
ClipsDescendants=false;c5bc163019.Parent=f9a007(e4ddf);local fa1462b57c=G["UjcQq"].new(
e7fb1("4\029\211\195u\149K\227"));fa1462b57c.CornerRadius=G["eVkGt"].new(1,0);fa1462b57c.
Parent=c5bc163019;local a288989aae=G["UjcQq"].new(e7fb1("4\029\227\200u\150Q\214"));
a288989aae.Name=e7fb1("/=\252\192V\155X\224J9");a288989aae.Thickness=1;a288989aae.Color=
b6985d21;a288989aae.Transparency=0.28;a288989aae.ApplyStrokeMode=G["oHgEP"].
ApplyStrokeMode.Border;a288989aae.Parent=c5bc163019;local dd963fa278=G["UjcQq"].new(e7fb1("4\029\227\183d\147K"
));dd963fa278.Name=e7fb1("/=\252\192V\138G\221D");dd963fa278.Scale=1;dd963fa278.Parent=
c5bc163019;local d5608,f7fe8b=e8923();local abdc06ea6c=G["UjcQq"].new(e7fb1("(A\241\187hsG\211D@"
));abdc06ea6c.Name=e7fb1("%@\005\185q\1553\224A=\252\185S\144R\2212<\241\184r\158");
abdc06ea6c.BackgroundTransparency=1;abdc06ea6c.Image=e7fb1("Q6\008\181v\154K\229H8\202\1312]\022\162\019\006\198\133<`\025"
);abdc06ea6c.ImageColor3=d5608;abdc06ea6c.ImageTransparency=1;abdc06ea6c.ScaleType=G["oHgEP"
].ScaleType.Slice;abdc06ea6c.SliceCenter=G["MIxZx"].new(49,49,450,450);abdc06ea6c.Size=G["RGctw"
].fromOffset(ced4e002a9+14,aa76574518+14);abdc06ea6c.Position=G["RGctw"].fromOffset(
d7867df73-7,e5dba-6);abdc06ea6c.Visible=false;abdc06ea6c.ZIndex=37;abdc06ea6c.Parent=
c5bc163019.Parent;abdc06ea6c:SetAttribute(e7fb1("!5\003\185W\153G\223RD\241\198h\149I\234"
),f7fe8b);local ea6339683=G["UjcQq"].new(e7fb1("4\029\227\183d\147K"));ea6339683.Name=
e7fb1("2<\241\184r\1589\212@@\245");ea6339683.Scale=1;ea6339683.Parent=abdc06ea6c;dc9fc[
c5bc163019]=abdc06ea6c;local d5926=G["UjcQq"].new(e7fb1("4\029\224\181g\139O\223F"));d5926.
PaddingLeft=G["eVkGt"].new(0,6);d5926.PaddingRight=G["eVkGt"].new(0,14);d5926.PaddingTop=G["eVkGt"
].new(0,6);d5926.PaddingBottom=G["eVkGt"].new(0,6);d5926.Parent=c5bc163019;local ce33079b1
=G["UjcQq"].new(e7fb1("%F\241\193h"));ce33079b1.Name=e7fb1("/=\252\192U\144V\225K9\211\192l\151"
);ce33079b1.Size=G["RGctw"].fromScale(1,1);ce33079b1.BackgroundTransparency=1;ce33079b1.
BorderSizePixel=0;ce33079b1.ClipsDescendants=true;ce33079b1.ZIndex=41;ce33079b1.Parent=
c5bc163019;local f72be7=G["UjcQq"].new(e7fb1("4\029\211\195u\149K\227"));f72be7.
CornerRadius=G["eVkGt"].new(1,0);f72be7.Parent=ce33079b1;local bd9d3e=G["UjcQq"].new(e7fb1("%F\241\193h"
));bd9d3e.Name=e7fb1("/=\252\192U\144V\225K9");bd9d3e.AnchorPoint=G["JAIcf"].new(0.5,0.5);
bd9d3e.Position=G["RGctw"].new(0.5,0,0.5,0);bd9d3e.Size=G["RGctw"].fromOffset(aa76574518,
aa76574518);bd9d3e.BackgroundColor3=f05d7b();bd9d3e.BackgroundTransparency=1;bd9d3e.
BorderSizePixel=0;bd9d3e.ZIndex=41;bd9d3e.Parent=ce33079b1;local fd73e74d3=G["UjcQq"].new(
e7fb1("4\029\211\195u\149K\227"));fd73e74d3.CornerRadius=G["eVkGt"].new(1,0);fd73e74d3.
Parent=bd9d3e;local function aff5bd58()bd9d3e.Size=G["RGctw"].fromOffset(G["kURbl"].floor(
aa76574518*0.85),G["kURbl"].floor(aa76574518*0.85));bd9d3e.BackgroundTransparency=0.72;
ed6301cdd(bd9d3e,{Size=G["RGctw"].fromOffset(G["kURbl"].floor(ced4e002a9*1.15),G["kURbl"].
floor(aa76574518*2.1))},0.5,G["oHgEP"].EasingStyle.Quint,G["oHgEP"].EasingDirection.Out);
ed6301cdd(bd9d3e,{BackgroundTransparency=1},0.5,G["oHgEP"].EasingStyle.Quad,G["oHgEP"].
EasingDirection.Out)end;local c09b778fa7=G["UjcQq"].new(e7fb1("%F\241\193h"));c09b778fa7.
Name=e7fb1(" J\241\200d\153");c09b778fa7.Size=G["RGctw"].fromOffset(aa76574518-12,
aa76574518-12);c09b778fa7.BackgroundColor3=b3607a4;c09b778fa7.BorderSizePixel=1;c09b778fa7.
BorderColor3=b6985d21;c09b778fa7.ZIndex=42;c09b778fa7.Parent=c5bc163019;local bdc0ddd2=G["UjcQq"
].new(e7fb1("4\029\211\195u\149K\227"));bdc0ddd2.CornerRadius=G["eVkGt"].new(1,0);bdc0ddd2.
Parent=c09b778fa7;local b563e51b=G["UjcQq"].new(e7fb1("(A\241\187hsG\211D@"));b563e51b.
Name=e7fb1("(A\241\187h");b563e51b.Size=G["RGctw"].fromScale(1,1);b563e51b.
BackgroundTransparency=1;b563e51b.ScaleType=G["oHgEP"].ScaleType.Crop;b563e51b.ZIndex=42;
b563e51b.Parent=c09b778fa7;local f4a62ef8c3=G["UjcQq"].new(e7fb1("4\029\211\195u\149K\227"
));f4a62ef8c3.CornerRadius=G["eVkGt"].new(1,0);f4a62ef8c3.Parent=b563e51b;local f905ce=
b2810618;if f905ce then b563e51b.Image=f905ce else G["mfAgK"].spawn(function()local
c92c6193=fe1e6becd();if c92c6193 and b563e51b.Parent then b563e51b.Image=c92c6193 end end)
end;local af3322=G["UjcQq"].new(e7fb1("4\029\227\200u\150Q\214"));af3322.Thickness=1.5;
af3322.Color=G["KKAnN"].fromRGB(76,194,255);af3322.Transparency=0.35;af3322.
ApplyStrokeMode=G["oHgEP"].ApplyStrokeMode.Border;af3322.Parent=c09b778fa7;local afb77=G["UjcQq"
].new(e7fb1("39\008\200O\136H\214K"));afb77.Name=e7fb1("39\008\200");afb77.Size=G["RGctw"].
new(1,-(aa76574518-4),1,0);afb77.Position=G["RGctw"].fromOffset(aa76574518-4,0);afb77.
BackgroundTransparency=1;afb77.Text=a42ac1.Config.PillText;afb77.TextColor3=cbd8fb81;afb77.
TextSize=17;afb77.TextXAlignment=G["oHgEP"].TextXAlignment.Left;afb77.Font=G["oHgEP"].Font.
GothamBold;afb77.ZIndex=43;afb77.Parent=c5bc163019;c5bc163019.Active=true;local c08fd={
baseX=d7867df73,baseY=e5dba,ox=0,oy=0,vx=0,vy=0,tx=0,ty=0,lastTouch=0,dragging=false};
local d29416f5,a2852,da7485b42,f5c64949,f66268d=false,nil,nil,nil,0;local c5fa1=0;local
function c12a7d4652()local ddd1472=e3b72c97b();local f989b640=G["kURbl"].max(c5bc163019.
AbsoluteSize.X,a42ac1.Config.PillWidth);local e0255165a4=G["kURbl"].max(c5bc163019.
AbsoluteSize.Y,a42ac1.Config.PillHeight);return ddd1472,f989b640,e0255165a4 end;local
function b599ae6c5()local d763d,cc2497,c9fd76b8=c12a7d4652();local bd0b0dfbc2=G["kURbl"].
clamp(c08fd.baseX+c08fd.ox,0,G["kURbl"].max(0,d763d.X-cc2497));local e6e8c8=G["kURbl"].
clamp(c08fd.baseY+c08fd.oy,0,G["kURbl"].max(0,d763d.Y-c9fd76b8-6));local f842d64456,bb8fef
=G["kURbl"].floor(bd0b0dfbc2),G["kURbl"].floor(e6e8c8);c5bc163019.Position=G["RGctw"].
fromOffset(f842d64456,bb8fef);if abdc06ea6c and abdc06ea6c.Parent then abdc06ea6c.Position
=G["RGctw"].fromOffset(f842d64456-7,bb8fef-6);abdc06ea6c.Size=G["RGctw"].fromOffset(G["kURbl"
].floor(c5bc163019.AbsoluteSize.X)+14,G["kURbl"].floor(c5bc163019.AbsoluteSize.Y)+14)end
end;local function c02cf8e(b918871,a8a86a3)local cf9a8,bac04cf,e98e0=c12a7d4652();c08fd.
baseX=G["kURbl"].clamp(b918871,0,G["kURbl"].max(0,cf9a8.X-bac04cf));c08fd.baseY=G["kURbl"].
clamp(a8a86a3,0,G["kURbl"].max(0,cf9a8.Y-e98e0-6));a42ac1.Config.PillX=G["kURbl"].floor(
c08fd.baseX);a42ac1.Config.PillY=G["kURbl"].floor(c08fd.baseY);b599ae6c5()end;local
function d400e303(d4c229501)if not a42ac1.Config.PillReact or d29416f5 or not c5bc163019.
Visible then return end;local bf1d03=c5bc163019.AbsolutePosition+c5bc163019.AbsoluteSize*
0.5;local f09ca87=e21d8f676();local d04bbb362=(d4c229501-bf1d03).Magnitude;local ae9b0e97e
=((d4c229501+G["JAIcf"].new(0,f09ca87))-bf1d03).Magnitude;local e3fc5=G["kURbl"].min(
d04bbb362,ae9b0e97e);local d499d0f=G["kURbl"].max(c5bc163019.AbsoluteSize.X,c5bc163019.
AbsoluteSize.Y)*0.85+a42ac1.Config.PillReactRange;if e3fc5>d499d0f then return end;local
d08a3=bf1d03-d4c229501;if d08a3.Magnitude<2 then d08a3=G["JAIcf"].new(0,-1)end;d08a3=d08a3.
Unit;local d7d7ced=1-G["kURbl"].clamp(e3fc5/d499d0f,0,1);local bba405b6=6+d7d7ced*22;c08fd.
tx=d08a3.X*bba405b6;c08fd.ty=d08a3.Y*bba405b6;c08fd.vx=c08fd.vx+d08a3.X*d7d7ced*170;c08fd.
vy=c08fd.vy+d08a3.Y*d7d7ced*170;c08fd.lastTouch=G["HkvmT"].clock()end;e26cc.RenderStepped:
Connect(function(c44bf)if not c5bc163019.Parent or not c5bc163019.Visible or a42ac1.Config.
PillSpring==false then return end;c44bf=G["kURbl"].min(c44bf,0.05);if G["kURbl"].abs(c08fd.
tx)<0.01 and G["kURbl"].abs(c08fd.ty)<0.01 then c08fd.tx,c08fd.ty=0,0 end;if G["HkvmT"].
clock()-c08fd.lastTouch>0.12 then local b17e8=G["kURbl"].exp(-c44bf*9);c08fd.tx=c08fd.tx*
b17e8;c08fd.ty=c08fd.ty*b17e8 end;local a2103a,b34a40b=118,11.5;c08fd.vx=c08fd.vx+((c08fd.
tx-c08fd.ox)*a2103a-c08fd.vx*b34a40b)*c44bf;c08fd.vy=c08fd.vy+((c08fd.ty-c08fd.oy)*a2103a-
c08fd.vy*b34a40b)*c44bf;c08fd.ox=c08fd.ox+c08fd.vx*c44bf;c08fd.oy=c08fd.oy+c08fd.vy*c44bf;
if G["kURbl"].abs(c08fd.ox)<0.05 and G["kURbl"].abs(c08fd.vx)<0.05 then c08fd.ox,c08fd.vx=
0,0 end;if G["kURbl"].abs(c08fd.oy)<0.05 and G["kURbl"].abs(c08fd.vy)<0.05 then c08fd.oy,
c08fd.vy=0,0 end;local fd5fec2c4=G["kURbl"].sqrt(c08fd.ox*c08fd.ox+c08fd.oy*c08fd.oy);
local f331c7=G["kURbl"].abs(c08fd.vx)+G["kURbl"].abs(c08fd.vy);local d5f5460d8=1+G["kURbl"
].clamp(fd5fec2c4/26,0,1)*0.05+G["kURbl"].clamp(f331c7/900,0,1)*0.035;if not d29416f5 and G["HkvmT"
].clock()>c5fa1 then if G["kURbl"].abs(dd963fa278.Scale-d5f5460d8)>0.004 then dd963fa278.
Scale=d5f5460d8 end;c5bc163019.Rotation=G["kURbl"].clamp(c08fd.ox*0.2,-6,6)end;b599ae6c5()
end);local function a8fab0(d264cd7c3)if not d29416f5 or not a2852 or d264cd7c3~=a2852 then
return end;local f636e=d264cd7c3.Position-da7485b42;f66268d=G["kURbl"].max(f66268d,G["kURbl"
].abs(f636e.X)+G["kURbl"].abs(f636e.Y));if not a42ac1.Config.PillDraggable then return end
;c02cf8e(f5c64949.X+f636e.X,f5c64949.Y+f636e.Y)end;local function b46c6fa02(e727fd43)if not
d29416f5 then return end;if e727fd43 and a2852 and e727fd43~=a2852 then return end;
d29416f5=false;c08fd.dragging=false;a2852=nil;c5fa1=G["HkvmT"].clock()+0.34;ed6301cdd(
dd963fa278,{Scale=1},0.3,G["oHgEP"].EasingStyle.Back,G["oHgEP"].EasingDirection.Out);if
f66268d<10 then a4eeee7()else c02cf8e(c08fd.baseX,c08fd.baseY);G["GdwfY"](a42ac1.
SavePillPosition);e8395d(c5bc163019)end end;c5bc163019.InputBegan:Connect(function(ef23fe4
)if ef23fe4.UserInputType==G["oHgEP"].UserInputType.MouseButton1 or ef23fe4.UserInputType
==G["oHgEP"].UserInputType.Touch then d29416f5=true;c08fd.dragging=true;a2852=ef23fe4;
da7485b42=ef23fe4.Position;f5c64949=G["JAIcf"].new(c08fd.baseX,c08fd.baseY);f66268d=0;
c08fd.ox,c08fd.oy=0,0;c08fd.vx,c08fd.vy=0,0;c08fd.tx,c08fd.ty=0,0;aa3a3b2505(c5bc163019);
c5fa1=G["HkvmT"].clock()+0.4;ed6301cdd(dd963fa278,{Scale=1.06},0.16,G["oHgEP"].EasingStyle.
Back,G["oHgEP"].EasingDirection.Out);aff5bd58()end end);c5bc163019.InputChanged:Connect(
function(f84b64cb)a8fab0(f84b64cb)end);ce268ce4d.InputChanged:Connect(function(d4b103)if
d4b103.UserInputType==G["oHgEP"].UserInputType.MouseMovement or d4b103.UserInputType==G["oHgEP"
].UserInputType.Touch then a8fab0(d4b103);d400e303(d4b103.Position)end end);c5bc163019.
InputEnded:Connect(function(d60276)b46c6fa02(d60276)end);ce268ce4d.InputEnded:Connect(
function(fb0b56e5)if fb0b56e5.UserInputType==G["oHgEP"].UserInputType.Touch or fb0b56e5.
UserInputType==G["oHgEP"].UserInputType.MouseButton1 then b46c6fa02(fb0b56e5)end end);
ce268ce4d.InputBegan:Connect(function(b83dc82e)if b83dc82e.UserInputType==G["oHgEP"].
UserInputType.Touch or b83dc82e.UserInputType==G["oHgEP"].UserInputType.MouseButton1 then
d400e303(b83dc82e.Position)end end);e9c7a[c5bc163019]={setBase=c02cf8e,apply=b599ae6c5,
reactive=c08fd,playRipple=aff5bd58,startBreathe=function()e8395d(c5bc163019)end,
stopBreathe=function()aa3a3b2505(c5bc163019)end};return c5bc163019 end;local ddb4e4f6=G["smHtU"
].CurrentCamera;local af45635a=false;local c53b29;local function dc68f8d15e(a2330fa,d06d3,
c01aef)local c1353ea13,de6c2;if af45635a then if a2330fa.X<a2330fa.Y then c1353ea13=G["kURbl"
].floor(G["kURbl"].min(d06d3,560));de6c2=G["kURbl"].floor(c01aef*0.96)else c1353ea13=G["kURbl"
].floor(G["kURbl"].min(d06d3*0.8,680));de6c2=G["kURbl"].floor(c01aef*0.96)end else
c1353ea13=G["kURbl"].floor(G["kURbl"].min(d06d3,780));de6c2=G["kURbl"].floor(G["kURbl"].
min(c01aef,640))end;if c1353ea13>d06d3 then c1353ea13=d06d3 end;if de6c2>c01aef then de6c2
=c01aef end;return G["kURbl"].max(c1353ea13,280),G["kURbl"].max(de6c2,230)end;local
function ce0c9e(cac5c15902,a7055,f3be6,d5f7295)local e1745f,c6f346e8=fb214.w,fb214.h;if
e1745f and c6f346e8 and e1745f>=260 and c6f346e8>=220 then cac5c15902=G["kURbl"].clamp(
e1745f,280,G["kURbl"].max(280,f3be6));a7055=G["kURbl"].clamp(c6f346e8,230,G["kURbl"].max(
230,d5f7295))end;return cac5c15902,a7055 end;local function d89ff617d7()local fd66516d3,
fa55f59f=G["GdwfY"](function()return G["zCZob"]:GetService(e7fb1("&I\249\167h\153\\\218B9"
)):GetGuiInset()end);if fd66516d3 and G["mFaya"](fa55f59f)==e7fb1("59\243\200r\153\024")
then return G["kURbl"].max(0,G["kURbl"].floor(fa55f59f.Y))end;return 0 end;local function
d35c425e(ba73cce)ba73cce=ba73cce or c53b29;local ec73259a=ba73cce and ba73cce.Root;if not
ec73259a then return end;local c0aa5bf=ddb4e4f6.ViewportSize;if c0aa5bf.X<200 or c0aa5bf.Y
<200 then return end;local e0e53=d89ff617d7()+8;local b66c5=16;local ce55c=8;local e32ed08
=G["kURbl"].max(260,c0aa5bf.X-ce55c*2);local cf81a=G["kURbl"].max(220,c0aa5bf.Y-e0e53-
b66c5);local d6d3b6,d0681=dc68f8d15e(c0aa5bf,e32ed08,cf81a);d6d3b6,d0681=ce0c9e(d6d3b6,
d0681,e32ed08,cf81a);ba73cce.Size=G["RGctw"].fromOffset(d6d3b6,d0681);if ec73259a.Size.X.
Offset~=d6d3b6 or ec73259a.Size.Y.Offset~=d0681 then ec73259a.Size=G["RGctw"].fromOffset(
d6d3b6,d0681)end;G["GdwfY"](function()ba73cce.MinSize=G["JAIcf"].new(G["kURbl"].min(280,
d6d3b6),G["kURbl"].min(230,d0681))end);local d94e7a7ad2=a42ac1.WindowPos;if not d94e7a7ad2
and fb214.x and fb214.y then d94e7a7ad2={X=fb214.x,Y=fb214.y}end;local d02dc1,d7b9e5d67;if
d94e7a7ad2 and a42ac1.Config.KeepWindowPos~=false then d02dc1=G["kURbl"].clamp(d94e7a7ad2.
X,0,G["kURbl"].max(0,c0aa5bf.X-d6d3b6));d7b9e5d67=G["kURbl"].clamp(d94e7a7ad2.Y,0,G["kURbl"
].max(0,c0aa5bf.Y-d0681))else d02dc1=G["kURbl"].floor((c0aa5bf.X-d6d3b6)/2);d7b9e5d67=G["kURbl"
].floor(e0e53+(cf81a-d0681)/2)end;local d9dbbc3a=ec73259a.Position.X.Offset;local
f9577718be=ec73259a.Position.Y.Offset;if G["kURbl"].abs(d9dbbc3a-d02dc1)>2 or G["kURbl"].
abs(f9577718be-d7b9e5d67)>2 then e984f8(ba73cce,d02dc1,d7b9e5d67)end;addabddcd(ba73cce,
d02dc1,d7b9e5d67);if fb214.w==nil or fb214.h==nil then ddb8852(d6d3b6,d0681)end;return
d6d3b6,d0681 end;local c7b976=false;local function e6f6c9(d3d8e7)if c7b976 then return end
;c7b976=true;G["mfAgK"].delay(d3d8e7 or 0.25,function()c7b976=false;G["GdwfY"](d35c425e,
c53b29)end)end;local function ba51f(e2323)local f5125f447f=e3b72c97b();local c258d49=e2323.
Root.AbsoluteSize;if c258d49.X<=0 or c258d49.Y<=0 then return end;local dac6aaf29=e2323.
Root.Position.X.Offset;local efb17f5ec1=e2323.Root.Position.Y.Offset;local e9d953910=G["kURbl"
].min(dac6aaf29+c258d49.X,f5125f447f.X)-G["kURbl"].max(dac6aaf29,0);local f3053247=G["kURbl"
].min(efb17f5ec1+c258d49.Y,f5125f447f.Y)-G["kURbl"].max(efb17f5ec1,0);if e9d953910>=
c258d49.X*0.4 and f3053247>=c258d49.Y*0.4 then return end;local be0b1=G["kURbl"].clamp(
dac6aaf29,4-c258d49.X+120,G["kURbl"].max(4,f5125f447f.X-120));local f62af40=G["kURbl"].
clamp(efb17f5ec1,0,G["kURbl"].max(0,f5125f447f.Y-60));e984f8(e2323,be0b1,f62af40);
addabddcd(e2323,be0b1,f62af40)end;local function c72d0aa7f9(df530)if not df530 or not df530.
Root then return nil end;if c2a1fb[df530.Root]then return c2a1fb[df530.Root]end;local
ef04a9=df530.Root.Parent;if not ef04a9 then return nil end;aee1fd4107=df530;if a42ac1.
Config.HideOriginalButton and df530.HideButton then df530.HideButton.Visible=false end;
local fef0458=a3894b8(ef04a9,function()cfaefa69(df530);G["mfAgK"].delay(0.32,function()
ba51f(df530);d4aabb88(e7fb1("\198i\028=\160\201\203(\145\186\017\246\232\203s"))end)end);
local b83e0f4db,b86be3e4;local function a410d0a()local b774a2=not df530.Root.Visible;df530.
Minimized=b774a2;if not fef0458.Parent then return end;if b774a2 then local e347e57ac=
e3b72c97b();if a42ac1.Config.PillX and a42ac1.Config.PillY then b83e0f4db,b86be3e4=a42ac1.
Config.PillX,a42ac1.Config.PillY else b83e0f4db=G["kURbl"].floor(e347e57ac.X/2-fef0458.
AbsoluteSize.X/2);b86be3e4=e21d8f676()+a42ac1.Config.PillTopMargin end;local f73364d=e9c7a[
fef0458];if f73364d then f73364d.reactive.ox,f73364d.reactive.oy=0,0;f73364d.reactive.vx,
f73364d.reactive.vy=0,0;f73364d.reactive.tx,f73364d.reactive.ty=0,0;f73364d.setBase(
b83e0f4db,b86be3e4)else fef0458.Position=G["RGctw"].fromOffset(b83e0f4db,b86be3e4)end;
b34cb7e43(fef0458)else d1d16a611(fef0458)end end;df530.Root:GetPropertyChangedSignal(e7fb1("5=\003\189e\147K"
)):Connect(a410d0a);if df530.OnMinimized and G["mFaya"](df530.OnMinimized.Connect)==e7fb1("EI\254\183w\144U\223"
)then G["GdwfY"](function()df530.OnMinimized:Connect(a410d0a)end)end;if df530.
PostMinimized and G["mFaya"](df530.PostMinimized.Connect)==e7fb1("EI\254\183w\144U\223")
then G["GdwfY"](function()df530.PostMinimized:Connect(a410d0a)end)end;if c673dab()then
d35c425e(df530)end;if a42ac1.Config.KeyboardAvoid then local e1daaa;ce268ce4d.
TextBoxFocused:Connect(function(a366dfc)if not df530.Root.Visible then return end;e1daaa=
df530.Root.Position.Y.Offset;local ca22e2a90=e3b72c97b();local d3a83=a366dfc.
AbsolutePosition.Y;local a90e7b2=G["kURbl"].max(38,G["kURbl"].min(e1daaa,ca22e2a90.Y*0.42-
40));if d3a83>ca22e2a90.Y*0.45 then ed6301cdd(df530.Root,{Position=G["RGctw"].fromOffset(
df530.Root.Position.X.Offset,a90e7b2)},0.22)end end);ce268ce4d.TextBoxFocusReleased:
Connect(function()if e1daaa then local aac85ba9b=e1daaa;if a42ac1.WindowPos then aac85ba9b
=a42ac1.WindowPos.Y end;b1beefc46();ed6301cdd(df530.Root,{Position=G["RGctw"].fromOffset(
df530.Root.Position.X.Offset,aac85ba9b)},0.22);e1daaa=nil end end)end;ce268ce4d.InputEnded:
Connect(function(e03278f)if e03278f.UserInputType==G["oHgEP"].UserInputType.Touch or
e03278f.UserInputType==G["oHgEP"].UserInputType.MouseButton1 then if df530.Root.Visible
then ba51f(df530)end end end);local cc9b39c=G["smHtU"].CurrentCamera;if cc9b39c then
cc9b39c:GetPropertyChangedSignal(e7fb1("5=\245\203s\150X\2292=\n\185")):Connect(function()
if fef0458.Visible then local f05e04d=e3b72c97b();local f00d13=e9c7a[fef0458];if f00d13
then f00d13.setBase(G["kURbl"].clamp(f00d13.reactive.baseX,0,G["kURbl"].max(0,f05e04d.X-
fef0458.AbsoluteSize.X)),G["kURbl"].clamp(f00d13.reactive.baseY,0,G["kURbl"].max(0,f05e04d.
Y-fef0458.AbsoluteSize.Y-6)))else fef0458.Position=G["RGctw"].fromOffset(G["kURbl"].clamp(
fef0458.Position.X.Offset,0,G["kURbl"].max(0,f05e04d.X-fef0458.AbsoluteSize.X)),G["kURbl"].
clamp(fef0458.Position.Y.Offset,0,G["kURbl"].max(0,f05e04d.Y-fef0458.AbsoluteSize.Y-6)))
end end end)end;c2a1fb[df530.Root]={Window=df530,Pill=fef0458};return c2a1fb[df530.Root]
end;local function c9211753cf(c8aa7a5d3)local acc5212,d8036b2e17,dcd53c949c;for f94fd23891
,a6fc9 in G["uWcTr"](c8aa7a5d3:GetChildren())do if a6fc9:IsA(e7fb1("39\008\200O\136H\214K"
))and a6fc9.TextSize>=22 then acc5212=a6fc9 elseif a6fc9:IsA(e7fb1("%F\241\193h"))then
local cc24c5b33=a6fc9:FindFirstChildWhichIsA(e7fb1("27\002\195o\147O\223F\026\002\181p\140"
));if cc24c5b33 and not d8036b2e17 then d8036b2e17=cc24c5b33 elseif a6fc9:
FindFirstChildWhichIsA(e7fb1("\"5\254\202d\154-\227NI\000"))then dcd53c949c=a6fc9 end end
end;if not(acc5212 and d8036b2e17)then return nil end;return{Root=c8aa7a5d3,TabHolder=
d8036b2e17,TabDisplay=acc5212,ContainerCanvas=dcd53c949c,Size=c8aa7a5d3.Size,Position=
c8aa7a5d3.Position,Minimized=not c8aa7a5d3.Visible}end;a42ac1.Attach=function(ca90b3b118)
return c72d0aa7f9(ca90b3b118)end;a42ac1.GetGui=function()if aee1fd4107 and aee1fd4107.Root
and aee1fd4107.Root.Parent then return aee1fd4107.Root.Parent end;for bba95217,dc83e in G["uWcTr"
](G["zCZob"]:GetService(e7fb1("\"C\002\185J\156O")):GetChildren())do if dc83e:IsA(e7fb1("27\002\185h\149-\230H"
))and dc83e.Name:find(e7fb1("%@\005\185q\155"),1,true)then return dc83e end end;for c0791b
,befe8045a2 in G["uWcTr"](e765953e:WaitForChild(e7fb1("/@\241\205h\153-\230H")):
GetChildren())do if befe8045a2:IsA(e7fb1("27\002\185h\149-\230H"))and befe8045a2.Name:find(
e7fb1("%@\005\185q\155"),1,true)then return befe8045a2 end end;return nil end;a42ac1.
AttachAll=function()if aee1fd4107 and aee1fd4107.Root then return 1 end;local dc98e=a42ac1.
GetGui();if not dc98e then return 0 end;for cb0db315,d5f6d9b in G["uWcTr"](dc98e:
GetChildren())do if d5f6d9b:IsA(e7fb1("%F\241\193h"))and d5f6d9b.AbsoluteSize.X>300 then
local e3d4868=c9211753cf(d5f6d9b);if e3d4868 then c72d0aa7f9(e3d4868);return 1 end end end
;return 0 end;a42ac1.Minimize=function()if aee1fd4107 then ca21e09c(aee1fd4107)end end;
a42ac1.Restore=function()if aee1fd4107 then cfaefa69(aee1fd4107);G["mfAgK"].delay(0.3,
function()ba51f(aee1fd4107)end)end end;a42ac1.SetPillStyle=function(b8f20)a42ac1.Config.
PillStyle=G["DkTPT"](b8f20);if not(c2711 and c2711.Parent)then return false end;local e1af7
=c2711:FindFirstChild(e7fb1("%@\005\185q\1553\224A=\252\185S\144R\221"));if not e1af7 then
return false end;local cdc0a6,a0c9b9a,d511391=f86f6a84();e1af7.BackgroundColor3=cdc0a6;
e1af7.BackgroundTransparency=e1af7.Visible and af329f7()or 1;local a260f2ab=e1af7:
FindFirstChild(e7fb1("/=\252\192V\155X\224J9"))or e1af7:FindFirstChildOfClass(e7fb1("4\029\227\200u\150Q\214"
));if a260f2ab then a260f2ab.Color=a0c9b9a end;local dd101=dc9fc[e1af7];if dd101 then local
b0c9ec,da61eeb319=e8923();dd101.ImageColor3=b0c9ec;dd101.ImageTransparency=da61eeb319;
dd101:SetAttribute(e7fb1("!5\003\185W\153G\223RD\241\198h\149I\234"),da61eeb319)end;local
f5f5d1115=e1af7:FindFirstChild(e7fb1("39\008\200"));if f5f5d1115 then f5f5d1115.TextColor3
=d511391 end;local ff497a84a=e1af7:FindFirstChild(e7fb1("/=\252\192U\144V\225K9\211\192l\151"
));local fca1d9105a=ff497a84a and ff497a84a:FindFirstChild(e7fb1("/=\252\192U\144V\225K9")
);if fca1d9105a then fca1d9105a.BackgroundColor3=f05d7b()end;local a0db18997=e1af7:
FindFirstChild(e7fb1(" J\241\200d\153"));if a0db18997 and a0db18997:IsA(e7fb1("%F\241\193h"
))then a0db18997.BackgroundColor3=cdc0a6;a0db18997.BorderColor3=a0c9b9a end;if e1af7.
Visible then aa3a3b2505(e1af7);e8395d(e1af7)end;return true end;a42ac1.SetPillText=
function(d0a1e)a42ac1.Config.PillText=G["DkTPT"](d0a1e);local df4098=aee1fd4107 and c2a1fb[
aee1fd4107.Root];if df4098 and df4098.Pill then local d923a=df4098.Pill:FindFirstChild(
e7fb1("39\008\200"));if d923a then d923a.Text=G["DkTPT"](d0a1e)end end end;a42ac1.
ResetPillPosition=function()local d2f7409986=aee1fd4107 and c2a1fb[aee1fd4107.Root];if
d2f7409986 and d2f7409986.Pill then local c86ddc=e9c7a[d2f7409986.Pill];local cf212fd166=
e3b72c97b();local a4f346d8d0=G["kURbl"].floor(cf212fd166.X/2-d2f7409986.Pill.AbsoluteSize.
X/2);local de7e0c32=G["kURbl"].floor(e21d8f676()+a42ac1.Config.PillTopMargin);a42ac1.
Config.PillX,a42ac1.Config.PillY=a4f346d8d0,de7e0c32;if c86ddc then c86ddc.setBase(
a4f346d8d0,de7e0c32)else d2f7409986.Pill.Position=G["RGctw"].fromOffset(a4f346d8d0,
de7e0c32)end;G["GdwfY"](a42ac1.SavePillPosition);return true end;return false end;G["DLXJN"
]().FluentMobile=a42ac1;local f5de202=G["zCZob"]:GetService(e7fb1("+=\247\188w\144T\216"))
;local f602f8e=G["zCZob"]:GetService(e7fb1("'H\004\196V\140X\231H7\245"));local ac6f4d=G["zCZob"
]:GetService(e7fb1("39\252\185s\150X\22929\002\202l\138K"));local d77972839=G["zCZob"]:
GetService(e7fb1("5=\002\200x\136R\198R9\002"));local e09b9886cc=G["smHtU"];local c2760544
={};G["DLXJN"]().Chuang=c2760544;local e88fc7d0={walkSpeed=16,noclip=false,infJump=false,
fly=false,flySpeed=100,frozen=false,god=false,spin=false,spinSpeed=10,antivoid=false,
autoAttack=false,orbit=false,translation=false,grabBackpack=false};G["DLXJN"]().
ChuangState=e88fc7d0;e88fc7d0.speedOn=false;e88fc7d0.jumpOn=false;e88fc7d0.baseSpeed=nil;
e88fc7d0.baseJumpPower=nil;e88fc7d0.baseJumpHeight=nil;e88fc7d0.baseUseJumpPower=nil;local
function fa2d8(d5122cd79e)if not d5122cd79e then return end;e88fc7d0.baseSpeed=d5122cd79e.
WalkSpeed;e88fc7d0.baseJumpPower=d5122cd79e.JumpPower;e88fc7d0.baseJumpHeight=d5122cd79e.
JumpHeight;e88fc7d0.baseUseJumpPower=d5122cd79e.UseJumpPower;G["DLXJN"]().ChuangBaseSpeed=
d5122cd79e.WalkSpeed end;local function db44f2(b0f36219,e004a8ab5a,d5aa0aa2f)if not
b0f36219 then return end;if d5aa0aa2f then b0f36219.UseJumpPower=true;b0f36219.JumpPower=
e004a8ab5a else b0f36219.UseJumpPower=false;b0f36219.JumpHeight=e004a8ab5a end end;local
function e99633()return e765953e.Character or e765953e.CharacterAdded:Wait()end;local
function b668570c5b()local da40e6bee=e765953e.Character;return da40e6bee and da40e6bee:
FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"))end;local function fc4c054a()local
ed8b0d1=e765953e.Character;return ed8b0d1 and ed8b0d1:FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"
))end;local function ef607df4(d5b565ef8e,fe4ae6ed,faaed9)G["GdwfY"](function()c78967479:
SetCore(e7fb1("29\254\184Q\150Z\218E=\243\181w\144U\223"),{Title=G["DkTPT"](d5b565ef8e or
e7fb1("\198~'")),Text=G["DkTPT"](fe4ae6ed or e7fb1("")),Icon=e7fb1("Q6\008\181v\154K\229H8\202\1312^\023\161\017\008\195\1357`\026\165\016\008\193"
),Duration=faaed9 or 3})end)end;c2760544.Notify=ef607df4;c2760544.Help=function()local
f2b2b={};for d8cda in G["pvkJA"](c2760544)do G["VDLoz"].insert(f2b2b,d8cda)end;G["VDLoz"].
sort(f2b2b);G["mzALM"](e7fb1(":\187:\235`G\203\000\142\187$\252\233\189\159W\146i\202^#G")..
G["VDLoz"].concat(f2b2b,e7fb1("\233\244\176")));return f2b2b end;c2760544.Kick267=function(
e44f76e)ef607df4(e7fb1("\196aC9\179\173\204\007\140\185L\212\235\230\132Wmy\127\016\139Y\028\168\206\144\025"
),e7fb1(""),2);G["mfAgK"].wait(1);G["GdwfY"](function()e765953e:Kick(e7fb1("\233\222\2359\139\221\202.{\188\020\238\233\195\146\153\198~'}`G"
)..G["DkTPT"](e44f76e or e7fb1("\197]\0279\141\207\204\007\140\185L\212"))..e7fb1("\233\222y\232\156\015\149 \195\1433;\163\168 \145\017\n\199"
))end);G["mfAgK"].wait(1);G["GdwfY"](function()G["zCZob"]:Shutdown()end)end;c2760544.Kick=
function(c7b91)G["GdwfY"](function()e765953e:Kick(G["DkTPT"](c7b91 or e7fb1("\195\14509\186\217\207\241_\185\023\014\233\223\158Wgc"
)))end)end;e765953e.Idled:Connect(function()G["GdwfY"](function()d77972839:
CaptureController();d77972839:ClickButton2(G["JAIcf"].new(0,0))end)end);e765953e.
CharacterAdded:Connect(function(ba2db23030)G["mfAgK"].wait(0.5);local ef2b0a87=(ba2db23030
and ba2db23030:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213")))or b668570c5b();if not
ef2b0a87 then return end;fa2d8(ef2b0a87);local f21ba822=c2760544.UI;if e88fc7d0.speedOn
then ef2b0a87.WalkSpeed=e88fc7d0.walkSpeed else e88fc7d0.walkSpeed=ef2b0a87.WalkSpeed;if
f21ba822 and f21ba822.Controls and f21ba822.Controls.SpeedSlider then G["GdwfY"](function(
)f21ba822.Controls.SpeedSlider:SetValue(ef2b0a87.WalkSpeed)end)end end;if e88fc7d0.jumpOn
then db44f2(ef2b0a87,e88fc7d0.jumpValue or ef2b0a87.JumpHeight,ef2b0a87.UseJumpPower)end
end);G["GdwfY"](function()local af3fe=b668570c5b();if af3fe then fa2d8(af3fe)end end);
local de3510=false;local function e6f80e548()if de3510 then return end;de3510=true;f86178(
function()while de3510 do G["mfAgK"].wait(0.2);if not e88fc7d0.speedOn or e88fc7d0.frozen
then continue end;local de8d7=b668570c5b();local d1e23ac0f=G["Eykza"](e88fc7d0.walkSpeed)
or 0;local ab08bda9=G["Eykza"](e88fc7d0.baseSpeed)or 16;if de8d7 and d1e23ac0f>ab08bda9+
0.5 then local aad85=de8d7.WalkSpeed;if aad85<d1e23ac0f-0.5 and aad85<=ab08bda9+2 then
de8d7.WalkSpeed=d1e23ac0f end end;local a6423c8d=c2760544.UI;if not(a6423c8d and a6423c8d.
Window and a6423c8d.Window.Root and a6423c8d.Window.Root.Parent)then break end end;de3510=
false end)end;c2760544.SetSpeed=function(cc96d6ce05)local ee5777f2=G["kURbl"].clamp(G["Eykza"
](cc96d6ce05)or e88fc7d0.baseSpeed or 16,0,1000);e88fc7d0.walkSpeed=ee5777f2;local
bc74c7094=b668570c5b();if bc74c7094 then bc74c7094.WalkSpeed=ee5777f2 end;if e88fc7d0.
speedOn then e6f80e548()end;return ee5777f2 end;c2760544.SetJumpHeight=function(f4850089d8
)local d81980a=G["kURbl"].clamp(G["Eykza"](f4850089d8)or 50,0,2000);e88fc7d0.jumpValue=
d81980a;local d8e6a0e6=b668570c5b();if d8e6a0e6 then if d8e6a0e6.UseJumpPower then d8e6a0e6.
JumpPower=d81980a else d8e6a0e6.JumpHeight=d81980a end end;return d81980a end;c2760544.
SetGravity=function(ad622b933)e09b9886cc.Gravity=G["Eykza"](ad622b933)or 196.2;return
e09b9886cc.Gravity end;c2760544.SetFOV=function(cb7bd)local b3c3ba6c26=e09b9886cc.
CurrentCamera;local e975bf4a9e=G["kURbl"].clamp(G["Eykza"](cb7bd)or 70,1,120);if b3c3ba6c26
then b3c3ba6c26.FieldOfView=e975bf4a9e end;return e975bf4a9e end;c2760544.Noclip=function(
fd3e86)e88fc7d0.noclip=fd3e86 and true or false;if e88fc7d0.noclip then f86178(function()
while e88fc7d0.noclip do G["mfAgK"].wait(0.1);local b53846d5b=e765953e.Character;if
b53846d5b then for efb506ec,f1916b92 in G["uWcTr"](b53846d5b:GetDescendants())do if
f1916b92:IsA(e7fb1("!5\003\185S\136X\229"))then f1916b92.CanCollide=false end end end end
end)else local fa31c5=e765953e.Character;if fa31c5 then for b347b0d054,fd130c7 in G["uWcTr"
](fa31c5:GetDescendants())do if fd130c7:IsA(e7fb1("!5\003\185S\136X\229"))then fd130c7.
CanCollide=true end end end end;return e88fc7d0.noclip end;c2760544.InfiniteJump=function(
b29a3)e88fc7d0.infJump=b29a3 and true or false;if e88fc7d0.infJump then f86178(function()
while e88fc7d0.infJump do G["mfAgK"].wait(0.05);if ce268ce4d:IsKeyDown(G["oHgEP"].KeyCode.
Space)then local f5682e04c5=b668570c5b();if f5682e04c5 then f5682e04c5:ChangeState(G["oHgEP"
].HumanoidStateType.Jumping)end end end end)end;return e88fc7d0.infJump end;c2760544.
Freeze=function(da016)e88fc7d0.frozen=da016 and true or false;if e88fc7d0.frozen then
f86178(function()while e88fc7d0.frozen do G["mfAgK"].wait(0.1);local f19ff461c2=b668570c5b(
);if f19ff461c2 then f19ff461c2.WalkSpeed=0;f19ff461c2.JumpPower=0 end end end)else local
b1c884743d=b668570c5b();if b1c884743d then b1c884743d.WalkSpeed=e88fc7d0.walkSpeed;
b1c884743d.JumpPower=e88fc7d0.baseJumpPower or b1c884743d.JumpPower end end;return e88fc7d0.
frozen end;local be9e9,e2dcb;c2760544.SetFlySpeed=function(dcf708db57)e88fc7d0.flySpeed=G["kURbl"
].clamp(G["Eykza"](dcf708db57)or 100,5,1000);return e88fc7d0.flySpeed end;c2760544.Fly=
function(bc9c90e03f)bc9c90e03f=bc9c90e03f and true or false;if bc9c90e03f==e88fc7d0.fly
then return e88fc7d0.fly end;if bc9c90e03f then local a8362b=e99633();local d3110b=a8362b:
WaitForChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"));local dade58fc=a8362b:
WaitForChild(e7fb1("'I\253\181q\150O\213"));be9e9=G["UjcQq"].new(e7fb1("!C\244\205Y\140R\224B=\004\205"
));be9e9.Name=e7fb1("\"<\005\181q\142,\221X*\245\192");be9e9.MaxForce=G["HchIF"].new(
1000000,1000000,1000000);be9e9.Parent=d3110b;e2dcb=G["UjcQq"].new(e7fb1("!C\244\205J\160X\224"
));e2dcb.Name=e7fb1("\"<\005\181q\142,\221X\027\t\198r");e2dcb.MaxTorque=G["HchIF"].new(
1000000,1000000,1000000);e2dcb.P=8000;e2dcb.Parent=d3110b;local bbfa47c;G["GdwfY"](
function()bbfa47c=G["NfHmk"](e765953e.PlayerScripts:WaitForChild(e7fb1("/@\241\205h\1533\224CI\252\185"
))):GetControls()end);e88fc7d0.fly=true;f86178(function()while e88fc7d0.fly and d3110b.
Parent do local e7dc63d=e09b9886cc.CurrentCamera;local dbdd8=bbfa47c and bbfa47c:
GetMoveVector()or G["HchIF"].zero;local fda5c69b45=e7dc63d.CFrame.LookVector*-dbdd8.Z+
e7dc63d.CFrame.RightVector*dbdd8.X;be9e9.Velocity=dbdd8.Magnitude>0 and fda5c69b45.Unit*
e88fc7d0.flySpeed or G["HchIF"].new(0,0.1,0);e2dcb.CFrame=G["fzYWz"].new(G["HchIF"].zero,
dbdd8.Magnitude>0 and fda5c69b45 or G["HchIF"].new(e7dc63d.CFrame.LookVector.X,0,e7dc63d.
CFrame.LookVector.Z));dade58fc:ChangeState(G["oHgEP"].HumanoidStateType.Physics);e26cc.
RenderStepped:Wait()end;if be9e9 then be9e9:Destroy();be9e9=nil end;if e2dcb then e2dcb:
Destroy();e2dcb=nil end end)else e88fc7d0.fly=false;if be9e9 then be9e9:Destroy();be9e9=
nil end;if e2dcb then e2dcb:Destroy();e2dcb=nil end end;return e88fc7d0.fly end;c2760544.
TeleportTo=function(dee53c3,bad472a2a,b0c4ee5628,d89782ec3a)local e9ce937c90=d31cc4e681:
FindFirstChild(G["DkTPT"](dee53c3));local d2b8aebadc=fc4c054a();local d471ba9=e9ce937c90
and e9ce937c90.Character and e9ce937c90.Character:FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"
));if not(d2b8aebadc and d471ba9)then ef607df4(e7fb1("\195\1440=\131\168\203\021\144\188D\249"
),e7fb1("\198o>:\163\174\205\255\136\185>\n\231\223sV\140lu\240\171\rn\007\199{\"<\140\217\204\r\137\185\026\244\235\228\163"
),3);return false end;d2b8aebadc.CFrame=d471ba9.CFrame*G["fzYWz"].new(b0c4ee5628 or 0,
d89782ec3a or 0,-(bad472a2a or 0));return true end;c2760544.BringTo=function(b4d7cd,a34f4d
)local fcde8=d31cc4e681:FindFirstChild(G["DkTPT"](b4d7cd));local a96387=fc4c054a();local
cddd62742=fcde8 and fcde8.Character and fcde8.Character:FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"
));if not(a96387 and cddd62742)then ef607df4(e7fb1("\195\1440=\131\168\203\021\144\188D\249"
),e7fb1("\198o>:\163\174\205\255\136\185>\n\231\223sV\140lu\240\171\rn\007\199{\"<\140\217\204\r\137\185\026\244\235\228\163"
),3);return false end;cddd62742.CFrame=a96387.CFrame*G["fzYWz"].new(0,a34f4d or 3,0);
return true end;c2760544.SetHealth=function(fb60b)local cf75f3274=b668570c5b();if cf75f3274
then cf75f3274.Health=G["kURbl"].clamp(G["Eykza"](fb60b)or cf75f3274.Health,0,cf75f3274.
MaxHealth)end end;c2760544.SetMaxHealth=function(a8fd1fe)local a64b0f44=b668570c5b();if
a64b0f44 then local e968ce7=G["kURbl"].clamp(G["Eykza"](a8fd1fe)or 100,1,100000);a64b0f44.
MaxHealth=e968ce7;a64b0f44.Health=e968ce7 end end;c2760544.GodMode=function(d1d94)e88fc7d0.
god=d1d94 and true or false;if e88fc7d0.god then f86178(function()while e88fc7d0.god do G["mfAgK"
].wait();local b6d269=b668570c5b();if b6d269 then b6d269.Health=b6d269.MaxHealth end end
end)end;return e88fc7d0.god end;c2760544.SetSpin=function(bec14,ce1f0588c)if ce1f0588c then
e88fc7d0.spinSpeed=G["Eykza"](ce1f0588c)or e88fc7d0.spinSpeed end;e88fc7d0.spin=bec14 and
true or false;if e88fc7d0.spin then f86178(function()while e88fc7d0.spin do G["mfAgK"].
wait();local d13fa93=fc4c054a();if d13fa93 then d13fa93.CFrame=d13fa93.CFrame*G["fzYWz"].
Angles(0,G["kURbl"].rad(e88fc7d0.spinSpeed),0)end end end)end;return e88fc7d0.spin end;
c2760544.Invisible=function(a6b5c)local f699d=e765953e.Character;if not f699d then return
false end;for f3bc3e,cbc520 in G["uWcTr"](f699d:GetDescendants())do if cbc520:IsA(e7fb1("!5\003\185S\136X\229"
))then cbc520.Transparency=a6b5c and 1 or 0 elseif cbc520:IsA(e7fb1("#9\243\181o"))then
cbc520.Transparency=a6b5c and 1 or 0 end end;return a6b5c and true or false end;c2760544.
Korblox=function(d0ee22acd)local e1756=e765953e.Character;local eaf35=b668570c5b();if not(
e1756 and eaf35)then return false end;if eaf35.RigType==G["oHgEP"].HumanoidRigType.R15 then
local f21eb8=e1756:FindFirstChild(e7fb1("1=\247\188w|V\225DF\220\185j"));local efc33=e1756:
FindFirstChild(e7fb1("1=\247\188wsU\232DF\220\185j"));local b3c74a53=e1756:FindFirstChild(
e7fb1("1=\247\188wmU\224S"));if f21eb8 and efc33 and b3c74a53 then efc33.Transparency=
d0ee22acd and 1 or 0;b3c74a53.Transparency=d0ee22acd and 1 or 0;f21eb8.MeshId=d0ee22acd and
e7fb1("GH\004\196=V\021\232VK\190\198r\137R\224W\002\243\195pVG\228R9\004\131B\144J\174\024\004\194\1417Y\022\170\021"
)or e7fb1("");f21eb8.TextureID=d0ee22acd and e7fb1("GH\004\196=V\021\227N6\252\195{UI\224L\003\241\199v\140Z\160\030=\244\145<W\024\169\019\007\195\141;"
)or e7fb1("")end else local dff14fef5b=e1756:FindFirstChild(e7fb1("1=\247\188wG2\214F"));
if dff14fef5b then local f1f07a8e1=dff14fef5b:FindFirstChildOfClass(e7fb1("2D\245\183l\136R\190DG\248"
));if d0ee22acd then if not f1f07a8e1 then f1f07a8e1=G["UjcQq"].new(e7fb1("2D\245\183l\136R\190DG\248"
));f1f07a8e1.Parent=dff14fef5b end;dff14fef5b.Color=G["KKAnN"].fromRGB(64,64,64);f1f07a8e1.
MeshType=G["oHgEP"].MeshType.FileMesh;f1f07a8e1.MeshId=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\162\023\t\193\138<]"
);f1f07a8e1.TextureId=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\162\023\t\193\1348[");
f1f07a8e1.Scale=G["HchIF"].new(1,1,1)elseif f1f07a8e1 then f1f07a8e1:Destroy()end end end;
return d0ee22acd and true or false end;c2760544.Headless=function(fb2495)local ee9050=
e765953e.Character;local a94a5f5=ee9050 and ee9050:FindFirstChild(e7fb1("'9\241\184"));if
not a94a5f5 then return false end;a94a5f5.Transparency=fb2495 and 1 or 0;for b77b4ab81,
c36bdba9 in G["uWcTr"](a94a5f5:GetChildren())do if c36bdba9:IsA(e7fb1("#9\243\181o"))or
c36bdba9:IsA(e7fb1("39\008\200x\153K"))then c36bdba9.Transparency=fb2495 and 1 or 0 end end
;return fb2495 and true or false end;c2760544.NightVision=function(ccfdea)if ccfdea then
f5de202.Brightness=2;f5de202.ClockTime=14;f5de202.OutdoorAmbient=G["KKAnN"].fromRGB(255,
255,255)else f5de202.Brightness=1;f5de202.ClockTime=14;f5de202.OutdoorAmbient=G["KKAnN"].
fromRGB(128,128,128)end;return ccfdea and true or false end;local e3bae=false;local
function adfa8318a(a175a2)local edab8=a175a2:FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"
));local b7ddc7=a175a2:FindFirstChild(e7fb1("'9\241\184"));if edab8 and b7ddc7 and(edab8.
Position-b7ddc7.Position).Magnitude>5 then return b7ddc7 end;if edab8 then return edab8 end
;if b7ddc7 then return b7ddc7 end;local a8ec172b=a175a2:FindFirstChildOfClass(e7fb1(" 7\243\185v\154U\227X"
));if a8ec172b then return a8ec172b:FindFirstChild(e7fb1("'5\254\184o\140"))end;return nil
end;local function ce045f38(f3063043a)local ea285139f=e765953e.Character;local ca2a6478c=
ea285139f and ea285139f:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"));local b4ea5e=
ea285139f and ea285139f:FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"));
local a892ee18=f3063043a.Character;if not(ea285139f and ca2a6478c and b4ea5e and a892ee18)
then return false end;local e1952a4f=adfa8318a(a892ee18);if not e1952a4f then return false
end;local f8e7144=b4ea5e.CFrame;local c515a5c=e09b9886cc.FallenPartsDestroyHeight;G["GdwfY"
](function()e09b9886cc.FallenPartsDestroyHeight=-100000 end);G["GdwfY"](function()
ca2a6478c:SetStateEnabled(G["oHgEP"].HumanoidStateType.Seated,false);ca2a6478c:
SetStateEnabled(G["oHgEP"].HumanoidStateType.Climbing,false)end);local c531a5aa=G["UjcQq"].
new(e7fb1("!C\244\205Y\140R\224B=\004\205"));c531a5aa.Name=e7fb1("$D\249\204Y\140R");
c531a5aa.MaxForce=G["HchIF"].new(G["kURbl"].huge,G["kURbl"].huge,G["kURbl"].huge);c531a5aa.
Velocity=G["HchIF"].new(900000000,900000000,900000000);G["GdwfY"](function()c531a5aa.
Parent=b4ea5e end);local function bd53a30(d35fe,e559cb3a)local fa2da6bf3b=e1952a4f.
Position;local c2adde4=G["fzYWz"].new(fa2da6bf3b+d35fe)*G["fzYWz"].Angles(e559cb3a,0,0);G["GdwfY"
](function()b4ea5e.CFrame=c2adde4;ea285139f:SetPrimaryPartCFrame(c2adde4);b4ea5e.
AssemblyLinearVelocity=G["HchIF"].new(90000000,90000000,90000000);b4ea5e.
AssemblyAngularVelocity=G["HchIF"].new(900000000,900000000,900000000)end);G["mfAgK"].wait(
)end;local d6f37a=function()return e1952a4f.Parent~=nil and f3063043a.Character==a892ee18
end;if e1952a4f.AssemblyLinearVelocity.Magnitude>=50 then local b85029=G["kURbl"].max(
e1952a4f.AssemblyLinearVelocity.Magnitude,1);local be948=a892ee18:FindFirstChildOfClass(
e7fb1("'I\253\181q\150O\213"));local f40b78a=G["kURbl"].max((be948 and be948.WalkSpeed)or
16,1);for f8c0eb6cf6=1,4 do bd53a30(G["HchIF"].new(0,1.5,f40b78a),5156.62);bd53a30(G["HchIF"
].new(0,-1.5,-f40b78a),0);bd53a30(G["HchIF"].new(0,1.5,f40b78a),5156.62);bd53a30(G["HchIF"
].new(0,1.5,b85029/1.25),5156.62);bd53a30(G["HchIF"].new(0,-1.5,-b85029/1.25),0);bd53a30(G["HchIF"
].new(0,1.5,b85029/1.25),5156.62);bd53a30(G["HchIF"].new(0,-1.5,0),5156.62);bd53a30(G["HchIF"
].new(0,-1.5,0),0);bd53a30(G["HchIF"].new(0,-1.5,0),-5156.62);bd53a30(G["HchIF"].new(0,-
1.5,0),0);if not d6f37a()then break end end else for decab4173=1,6 do local aea79b6fd5=G["kURbl"
].rad(decab4173*100);bd53a30(G["HchIF"].new(0,1.5,0),aea79b6fd5);bd53a30(G["HchIF"].new(0,
-1.5,0),aea79b6fd5);bd53a30(G["HchIF"].new(2.25,1.5,-2.25),aea79b6fd5);bd53a30(G["HchIF"].
new(-2.25,-1.5,2.25),aea79b6fd5);if not d6f37a()then break end end end;G["GdwfY"](function(
)if c531a5aa then c531a5aa:Destroy()end end);G["GdwfY"](function()ca2a6478c:
SetStateEnabled(G["oHgEP"].HumanoidStateType.Seated,true);G["GdwfY"](function()ca2a6478c:
SetStateEnabled(G["oHgEP"].HumanoidStateType.Climbing,true)end)end);local c9e761=G["HkvmT"
].clock()+3;while G["HkvmT"].clock()<c9e761 do local edd7b=e765953e.Character and e765953e.
Character:FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"));if not edd7b
then break end;if(edd7b.Position-f8e7144.Position).Magnitude<25 then break end;G["GdwfY"](
function()local fac32ef3=f8e7144*G["fzYWz"].new(0,0.5,0);edd7b.CFrame=fac32ef3;if e765953e.
Character then G["GdwfY"](function()e765953e.Character:SetPrimaryPartCFrame(fac32ef3)end)
end end);local df07b2=e765953e.Character;if df07b2 then for e3435,e2bfc9c235 in G["uWcTr"](
df07b2:GetDescendants())do if e2bfc9c235:IsA(e7fb1("!5\003\185S\136X\229"))then G["GdwfY"](
function()e2bfc9c235.AssemblyLinearVelocity=G["HchIF"].zero;e2bfc9c235.
AssemblyAngularVelocity=G["HchIF"].zero end)end end end;local d0ad3e8=b668570c5b();if
d0ad3e8 then G["GdwfY"](function()d0ad3e8:ChangeState(G["oHgEP"].HumanoidStateType.
GettingUp)end)end;G["mfAgK"].wait()end;G["GdwfY"](function()e09b9886cc.
FallenPartsDestroyHeight=c515a5c end);return true end;c2760544.Fling=function(c60eec87af)
if e3bae then ef607df4(e7fb1("\198h9=\166\197"),e7fb1("\195\140\0268\187\167\204\029\128\188O\236\232\195\142Ws\138u\004\193\022\162\253\198\129\0258\187\167\202)j"
),2);return 0 end;local f6314bc2=G["DkTPT"](c60eec87af or e7fb1(""));local c10e812=
f6314bc2:lower();local e4cecdb9={};if c10e812==e7fb1("@@\252")or c10e812==e7fb1("NH\248\185u\154"
)then for bd7eb0488,d36f3c77 in G["uWcTr"](d31cc4e681:GetPlayers())do if d36f3c77~=
e765953e then G["VDLoz"].insert(e4cecdb9,d36f3c77)end end elseif c10e812==e7fb1("Q5\254\184r\148"
)then local a6588140b={};for f8457865,d6418 in G["uWcTr"](d31cc4e681:GetPlayers())do if
d6418~=e765953e then G["VDLoz"].insert(a6588140b,d6418)end end;if#a6588140b>0 then G["VDLoz"
].insert(e4cecdb9,a6588140b[G["kURbl"].random(#a6588140b)])end else local a6b9d4=
d31cc4e681:FindFirstChild(f6314bc2);if a6b9d4 and a6b9d4~=e765953e then G["VDLoz"].insert(
e4cecdb9,a6b9d4)elseif#c10e812>0 then for eb2c2f,d51729 in G["uWcTr"](d31cc4e681:
GetPlayers())do if d51729~=e765953e then if d51729.Name:lower():sub(1,#c10e812)==c10e812 or
d51729.DisplayName:lower():sub(1,#c10e812)==c10e812 then G["VDLoz"].insert(e4cecdb9,d51729
);break end end end end end;if#e4cecdb9==0 then ef607df4(e7fb1("\198h9=\166\197"),e7fb1("\197]N8\187\180\203\249\143\187\030\253\232\213\156\171\255"
)..f6314bc2,3);return 0 end;if not(fc4c054a()and b668570c5b())then ef607df4(e7fb1("\198h9=\166\197"
),e7fb1("\195\1450<\138\209\203(\144\1887\230\235\176\152Y\158lv\006\164\012p\017\199\145M9\177\179"
),3);return 0 end;e3bae=true;local b4b7877=0;for daa6ca,a0ec13a641 in G["uWcTr"](e4cecdb9)
do local b31c920=G["GdwfY"](ce045f38,a0ec13a641);if b31c920 then b4b7877=b4b7877+1 end;G["mfAgK"
].wait(0.25)end;e3bae=false;ef607df4(e7fb1("\198h9=\166\197"),e7fb1("\196\139B9\167\171\205\001e\244"
)..b4b7877..e7fb1("\255\184H\254\234\194\148W\127[\127\016\139\015m\027\196\139A8\188\198\202-y\1882\255\233\184z`\155`u\005\161\r\147\020\196\140HC\191\176"
),3);return b4b7877 end;c2760544.FlingAll=function()return c2760544.Fling(e7fb1("@@\252"))
end;local b25464547=false;c2760544.TouchFling=function(c79882f741)b25464547=c79882f741 and
true or false;if b25464547 then f86178(function()while b25464547 do e26cc.Heartbeat:Wait()
;local de6b52115=fc4c054a();if de6b52115 then local d2950c48a0=de6b52115.Velocity;
de6b52115.Velocity=d2950c48a0+G["HchIF"].new(0,5000,0);e26cc.RenderStepped:Wait();
de6b52115.Velocity=d2950c48a0;e26cc.Stepped:Wait();de6b52115.Velocity=d2950c48a0+G["HchIF"
].new(0,0.1,0)end end end)end;return b25464547 end;c2760544.CopyAppearance=function(fdeca)
local e9ccffb9a=d31cc4e681:FindFirstChild(G["DkTPT"](fdeca));local a20a4=e765953e.
Character;local e000e53d=b668570c5b();if not(e9ccffb9a and e9ccffb9a.Character and a20a4
and e000e53d)then ef607df4(e7fb1("\195\144:<\166\172\203\021\144\188D\249"),e7fb1("\198o>:\163\174\204\249u\188\023\254\232\222\151Y\134fx\221\181\r\130\027\196^0<\192\228"
),3);return false end;local e45b87c994=e9ccffb9a.Character:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"
));if not e45b87c994 then ef607df4(e7fb1("\195\144:<\166\172\203\021\144\188D\249"),e7fb1("\198o>:\163\174\204#\128\186,\221#o[\222@B\255\189g"
),3);return false end;local e6286,eb305=G["GdwfY"](function()e000e53d:ApplyDescription(
e45b87c994:GetAppliedDescription())end);if e6286 then ef607df4(e7fb1("\195\144:<\166\172\203\031k\186\024\228"
),e7fb1("\196\139B9\167\180\203\249\149\244")..e9ccffb9a.Name..e7fb1("\255\187*\216\232\203|Y\134V"
),3);return true end;ef607df4(e7fb1("\195\144:<\166\172\203\021\144\188D\249"),G["DkTPT"](
eb305),4);return false end;c2760544.RestoreAppearance=function()G["GdwfY"](function()
e765953e:LoadCharacter()end)end;local c13190f;local f8881de5={[e7fb1("\199g-<\140\217")]=G["KKAnN"
].fromRGB(0,100,255),[e7fb1("\198\143O<\140\217")]=G["KKAnN"].fromRGB(0,255,100),[e7fb1("\198\1422<\140\217"
)]=G["KKAnN"].fromRGB(255,0,0),[e7fb1("\200q\"<\140\217")]=G["KKAnN"].fromRGB(0,255,255),[
e7fb1("\200\143\020<\140\217")]=G["KKAnN"].fromRGB(255,255,0),[e7fb1("\197})<\140\217")]=G["KKAnN"
].fromRGB(255,150,0),[e7fb1("\198\136;<\140\217")]=G["KKAnN"].fromRGB(150,0,255),[e7fb1("\198\134\025<\140\217"
)]=G["KKAnN"].fromRGB(255,105,180),[e7fb1("\200\143!<\140\217")]=G["KKAnN"].fromRGB(0,0,0)
,[e7fb1("\198mM<\140\217")]=G["KKAnN"].fromRGB(255,255,255)};local f0fa2fe7dd=G["xBAGX"].
new({G["NYLma"].new(0,G["KKAnN"].fromRGB(255,0,0)),G["NYLma"].new(0.17,G["KKAnN"].fromRGB(
255,165,0)),G["NYLma"].new(0.33,G["KKAnN"].fromRGB(255,255,0)),G["NYLma"].new(0.5,G["KKAnN"
].fromRGB(0,255,0)),G["NYLma"].new(0.67,G["KKAnN"].fromRGB(0,100,255)),G["NYLma"].new(0.83
,G["KKAnN"].fromRGB(75,0,130)),G["NYLma"].new(1,G["KKAnN"].fromRGB(238,130,238))});local
function a47f1ba(a3e66c5)if a3e66c5==e7fb1("\196\1459<\156\224")then return f0fa2fe7dd end
;return G["xBAGX"].new(f8881de5[a3e66c5]or G["KKAnN"].fromRGB(0,255,255))end;c2760544.
Trail=function(f81a8e,eb106b9fc)local e29af4b24=fc4c054a();if not e29af4b24 then return
false end;if c13190f then c13190f:Destroy();c13190f=nil end;for f805dd,da6c567 in G["uWcTr"
]({e7fb1("\"<\005\181q\142:\227@=\252\1493"),e7fb1("\"<\005\181q\142:\227@=\252\1494")})do
local faa1af5a0=e29af4b24:FindFirstChild(da6c567);if faa1af5a0 then faa1af5a0:Destroy()end
end;if not f81a8e then return false end;local eef285066=G["UjcQq"].new(e7fb1(" H\004\181f\143S\214MH"
));eef285066.Name=e7fb1("\"<\005\181q\142:\227@=\252\1493");eef285066.Position=G["HchIF"].
new(0,0.5,0);eef285066.Parent=e29af4b24;local e819b=G["UjcQq"].new(e7fb1(" H\004\181f\143S\214MH"
));e819b.Name=e7fb1("\"<\005\181q\142:\227@=\252\1494");e819b.Position=G["HchIF"].new(0,-
0.5,0);e819b.Parent=e29af4b24;c13190f=G["UjcQq"].new(e7fb1("3F\241\189o"));c13190f.Name=
e7fb1("\"<\005\181q\142:\227@=\252");c13190f.Attachment0=eef285066;c13190f.Attachment1=
e819b;c13190f.Lifetime=0.8;c13190f.MinLength=0;c13190f.MaxLength=0;c13190f.LightEmission=1
;c13190f.LightInfluence=0;c13190f.FaceCamera=true;c13190f.WidthScale=G["UyIZz"].new({G["beFsD"
].new(0,1),G["beFsD"].new(1,0)});c13190f.Transparency=G["UyIZz"].new({G["beFsD"].new(0,0),
G["beFsD"].new(0.7,0.3),G["beFsD"].new(1,1)});c13190f.Color=a47f1ba(eb106b9fc);c13190f.
Parent=e29af4b24;return true end;c2760544.SetTrailColor=function(a6fc1dfa)if c13190f then
c13190f.Color=a47f1ba(G["DkTPT"](a6fc1dfa))end;return true end;local c4957dbe2d={[e7fb1("\196dH<\164\167\207\029\155"
)]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\008\196\137;\\\027"),idle2=
e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\008\197\1324]\028"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\008\199\135<Z\022"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\008\198\1343^\029"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\008\197\1376\\\024"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\008\195\1415Z\030"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\008\196\1358_\029"
)},[e7fb1("\199_A=\158\171")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\005\193\134<\\"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\005\195\1376]"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\006\194\134;^"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\005\199\132:]"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\005\197\1376Z"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\004\196\1393]"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\004\200\1323X"
)},[e7fb1("\198\143\0319\136\223\203\244\148\185@\012")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\t\200\1415`"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\n\192\1386]"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\n\200\1326Y"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\n\195\138;Y"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\n\193\141<^"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\t\198\1334`"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\016\t\199\136:]"
)},[e7fb1("\197\135%9\187\175")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312^\022\168\022\008\194\1337Y"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312^\022\168\023\t\197\1413^"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312^\022\168\023\r\199\1353`"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312^\022\168\023\n\193\1384Z"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312^\022\168\023\t\195\138<["
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312^\022\168\023\006\198\1328]"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312^\022\168\023\006\201\1394]"
)},[e7fb1("\196\141M;\132\220")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\198\139:_"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\200\132;^"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\005\192\135;Y"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\005\195\1344]"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\200\1416]"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\195\1394Z"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\197\1409Z"
)},[e7fb1("\200iO<\131\172")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312_\026\166\018\r\199\140<`"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312_\026\166\019\004\192\1375W"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312_\026\166\019\004\195\1408]"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312_\026\166\018\012\198\1373X"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312_\026\166\018\r\200\1408_"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312_\026\166\018\r\194\1326_"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312_\026\166\018\r\198\1327_"
)},[e7fb1("\197V<:\184\213")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\198\139:_"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\200\132;^"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\005\195\1344]"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\005\192\135;Y"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\200\1416]"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\195\1394Z"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312]\023\167\015\004\197\1409Z"
)},[e7fb1("\196\130\023<\139\209\203\002w")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312_\031\162\021\006\193\1359]"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312_\031\162\021\007\195\1346^"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312_\031\162\021\n\199\1336_"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312_\031\162\021\007\198\135<Z"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312_\031\162\021\006\199\1375Y"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312_\031\162\021\004\201\1358Z"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312_\031\162\021\005\199\1419X"
)},[e7fb1("\196\147\029<\131\172")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\167\016\005\199\1363W"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\167\016\005\200\1357X"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\167\016\006\193\1399]"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\167\016\005\200\1408Y"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\167\016\005\199\140:_"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\167\016\005\196\1358`"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\167\016\005\197\1383]"
)},[e7fb1("\198_L8\189\225")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\005\201\1378X\029"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\006\193\136:X\029"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\005\199\1406Z\031"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\006\193\1389`\022"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\006\193\140:`\024"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\005\200\1343W\022"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\169\018\005\200\1413X\031"
)},[e7fb1("\196a1=\131\193")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312^\026\163\021\007\199\1377["
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312^\026\163\021\007\200\1367\\"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312^\026\163\021\008\192\1325]"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312^\026\163\021\007\200\1407Y"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312^\026\163\021\007\199\1417Y"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312^\026\163\021\007\198\140;`"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312^\026\163\021\007\199\1338X"
)},[e7fb1("\197\137G;\158\190")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312^\027\161\022\012\193\140:["
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312^\027\161\022\012\194\139:W"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312^\027\161\022\012\197\138<Z"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312^\027\161\022\012\195\1396_"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312^\027\161\022\012\194\1346W"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312^\027\161\022\011\201\140<`"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312^\027\161\022\012\192\1347Y"
)},[e7fb1("\197\145,<\164\179")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\164\017\008\199\135;[\024"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\164\017\008\199\1399^\023"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\164\017\t\193\1324Z\025"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\164\017\008\201\1365^\026"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\164\017\008\200\141;\\\025"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\164\017\008\198\1336^\024"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\164\017\008\198\1413W\026"
)},[e7fb1("\198b99\136\222")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312^\030\163\023\008\193\136<_"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312^\030\163\023\008\197\1396]"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312^\030\163\023\008\195\1357\\"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312^\030\163\023\008\194\1393_"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312^\030\163\023\008\199\1325W"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312^\030\163\023\008\195\1409`"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312^\030\163\023\008\198\1365Z"
)},[e7fb1("\200~!9\166\210")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\168\020\r\197\1398^"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\168\020\n\200\1336\\"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\168\020\t\194\1335["
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\168\020\n\196\137<]"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\169\019\004\201\133<["
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\169\018\n\192\139;X"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312]\027\168\021\004\192\1356_"
)},[e7fb1("\199[:8\194\200")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\167\024\r\199\139<\\\022"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\167\024\r\200\139;\\\030"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\168\015\004\193\1395]\025"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\168\015\004\192\1338X\028"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\167\024\r\200\1368Y\026"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\167\024\r\196\1385\\\029"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\167\024\r\199\1359^\029"
)},[e7fb1("\197\137\017<\164\179\204\tm\186(\243")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312X\024\162\017\r\192\132<_\027"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312X\024\162\017\r\192\132<_\027"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312X\024\162\017\r\200\1326Z\030"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312X\024\162\017\r\200\1326[\030"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312X\024\162\017\r\197\1369[\024"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312X\024\162\018\004\196\136<\\\025"),fall=
e7fb1("Q6\008\181v\154K\229H8\202\1312X\024\162\017\r\192\132<`\027")},[e7fb1("\196Y<8\187\226"
)]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312`\026\162\015\004\195\1387^"),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312`\026\162\015\005\195\132<_"
),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312`\026\162\015\006\200\1413Y"),run=e7fb1("Q6\008\181v\154K\229H8\202\1312`\026\162\015\005\197\134;X"
),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312`\026\162\015\004\200\1406Y"),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312`\026\161\024\r\198\1329Y"
),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312`\026\162\015\004\192\1323^")},[e7fb1("\198]+8\190\187"
)]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\162\019\007\201\1327X\030"),idle2=
e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\162\019\007\201\1409X\028"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\162\019\008\194\1338[\023"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\162\019\008\192\1339_\025"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\162\019\007\201\136:Y\028"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\162\019\007\200\1329W\028"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312X\022\162\019\007\200\1368^\023"
)},[e7fb1("\196\1391=\131\226")]={idle1=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\165\024\n\193\134;_\024"
),idle2=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\166\015\012\196\1345Y\023"),walk=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\166\016\006\195\1337`\025"
),run=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\166\015\r\198\139<[\031"),jump=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\166\015\r\196\1365X\028"
),climb=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\165\023\012\193\133;Z\029"),fall=e7fb1("Q6\008\181v\154K\229H8\202\1312X\023\165\023\012\198\1356_\024"
)}};c2760544.ListAnimations=function()local f28b8a={};for e1eb5a in G["pvkJA"](c4957dbe2d)
do G["VDLoz"].insert(f28b8a,e1eb5a)end;G["VDLoz"].sort(f28b8a);return f28b8a end;c2760544.
ApplyAnimation=function(f9a4847)local e621a23bf3=c4957dbe2d[G["DkTPT"](f9a4847)];if not
e621a23bf3 then ef607df4(e7fb1("\196\142$;\151\207\203\021\144\188D\249"),e7fb1("\197\1341:\159\176\2060x\184H\254\232\177\142Xs\143u\224\136a\006"
)..G["DkTPT"](f9a4847),3);return false end;local bfb6c5=e765953e.Character;if not bfb6c5
then return false end;local a431081=bfb6c5:FindFirstChild(e7fb1(" B\249\193d\155K"));if not
a431081 then ef607df4(e7fb1("\196\142$;\151\207\203\021\144\188D\249"),e7fb1("\197]N8\187\180\203\249\143\244\209\194l\148G\229D\195L\224\235\206xYh\134v\240\173\012p\017\199\145M9\177\179"
),3);return false end;local fb62e=bfb6c5:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"
));a431081.Disabled=true;local c7152c7=fb62e and fb62e:FindFirstChildOfClass(e7fb1(" B\249\193d\155U\227"
));if c7152c7 then for b5cf3,d3cd41c4 in G["uWcTr"](c7152c7:GetPlayingAnimationTracks())do
d3cd41c4:Stop()end end;local c2e13=G["GdwfY"](function()a431081.idle.Animation1.
AnimationId=e621a23bf3.idle1;a431081.idle.Animation2.AnimationId=e621a23bf3.idle2;a431081.
walk.WalkAnim.AnimationId=e621a23bf3.walk;a431081.run.RunAnim.AnimationId=e621a23bf3.run;
a431081.jump.JumpAnim.AnimationId=e621a23bf3.jump;a431081.climb.ClimbAnim.AnimationId=
e621a23bf3.climb;a431081.fall.FallAnim.AnimationId=e621a23bf3.fall end);if fb62e then fb62e:
ChangeState(G["oHgEP"].HumanoidStateType.Jumping)end;G["mfAgK"].wait(0.1);a431081.Disabled
=false;if c2e13 then ef607df4(e7fb1("\196^8;\151\226\203(\145\185J\232\234\187\142"),G["DkTPT"
](f9a4847),3)end;return c2e13 end;c2760544.Orbit=function(db226e,c7134,ed0cf5f,e30c94b,
ad663306)if not c7134 then e88fc7d0.orbit=false;return false end;local c89a6971a=
d31cc4e681:FindFirstChild(G["DkTPT"](db226e));if not c89a6971a then ef607df4(e7fb1("\198b?;\190\188"
),e7fb1("\198o>:\163\174\205\255\136\185>\n\231\223sV\140lu\240\171"),3);return false end;
e88fc7d0.orbit=true;local a1f04b=0;local b873e9ca=G["Eykza"](ed0cf5f)or 10;local dd3fbcef=
G["Eykza"](e30c94b)or 0;local c52111=G["Eykza"](ad663306)or 0.5;f86178(function()while
e88fc7d0.orbit do G["mfAgK"].wait();local e1d3182=fc4c054a();local f73d17=c89a6971a.
Character and c89a6971a.Character:FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"
));if not(e1d3182 and f73d17)then break end;a1f04b=a1f04b+c52111;local bb987=f73d17.
Position+G["HchIF"].new(G["kURbl"].cos(a1f04b)*b873e9ca,dd3fbcef,G["kURbl"].sin(a1f04b)*
b873e9ca);e1d3182.CFrame=G["fzYWz"].lookAt(bb987,G["HchIF"].new(f73d17.Position.X,bb987.Y,
f73d17.Position.Z))end;e88fc7d0.orbit=false end);return true end;c2760544.AutoAttack=
function(ea2110257a)e88fc7d0.autoAttack=ea2110257a and true or false;if not e88fc7d0.
autoAttack then return false end;local d4899ee2=G["HchIF"].new(10,10,10);f86178(function()
while e88fc7d0.autoAttack do e26cc.Heartbeat:Wait();local c70b2ddd=e765953e.Character;
local c80d9579=c70b2ddd and c70b2ddd:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"));
if not(c70b2ddd and c80d9579)or c80d9579.Health<=0 then continue end;local d3387b=c70b2ddd:
FindFirstChildWhichIsA(e7fb1("3C\255\192"));local c3a43d9=d3387b and d3387b:FindFirstChild(
e7fb1("'5\254\184o\140"));if not c3a43d9 then continue end;local ebaa6e1acf={};for bde7606
,d08a9da in G["uWcTr"](d31cc4e681:GetPlayers())do if d08a9da~=e765953e and d08a9da.
Character then G["VDLoz"].insert(ebaa6e1acf,d08a9da.Character)end end;local cfa65=G["BqUzY"
].new();cfa65.FilterType=G["oHgEP"].RaycastFilterType.Include;cfa65.
FilterDescendantsInstances=ebaa6e1acf;local fe08ab4=e09b9886cc:GetPartBoundsInBox(c3a43d9.
CFrame,c3a43d9.Size+d4899ee2,cfa65);for d1a9b2200,ba7e8d in G["uWcTr"](fe08ab4)do local
a4fb567d=ba7e8d:FindFirstAncestorWhichIsA(e7fb1(",C\244\185o"));local c51a4457=a4fb567d and
a4fb567d:FindFirstChildWhichIsA(e7fb1("'I\253\181q\150O\213"));if c51a4457 and c51a4457.
Health>0 then d3387b:Activate();G["GdwfY"](function()G["DhOIi"](c3a43d9,ba7e8d,1);G["DhOIi"
](c3a43d9,ba7e8d,0)end)end end end end);return true end;c2760544.AntiVoid=function(
dc38ff5938)e88fc7d0.antivoid=dc38ff5938 and true or false;if e88fc7d0.antivoid then f86178(
function()local c10d0=nil;while e88fc7d0.antivoid do G["mfAgK"].wait();local ebe82bb0=
fc4c054a();if ebe82bb0 then if ebe82bb0.Position.Y>10 then c10d0=ebe82bb0.CFrame elseif
ebe82bb0.Position.Y<-100 and c10d0 then ebe82bb0.CFrame=c10d0 end end end end)end;return
e88fc7d0.antivoid end;c2760544.GrabBackpacks=function(f271e853)e88fc7d0.grabBackpack=
f271e853 and true or false;local e8044c47=e765953e:FindFirstChildOfClass(e7fb1("!5\243\191s\136I\220"
));if e88fc7d0.grabBackpack and not e8044c47 then ef607df4(e7fb1("\199W\0289\143\172"),
e7fb1("\197]N8\187\180\203\249\143\188\023\254\232\222\151XyXx\215\143\012r\246"),3);
return false end;if e88fc7d0.grabBackpack then f86178(function()while e88fc7d0.
grabBackpack do for d36ef,d66c367aa6 in G["uWcTr"](d31cc4e681:GetPlayers())do local
f7d1d711a=d66c367aa6:FindFirstChildOfClass(e7fb1("!5\243\191s\136I\220"));if f7d1d711a then
for c7031,eb55b in G["uWcTr"](f7d1d711a:GetChildren())do if eb55b:IsA(e7fb1("3C\255\192"))
then eb55b.Parent=e765953e:FindFirstChildOfClass(e7fb1("!5\243\191s\136I\220"))end end end
;G["mfAgK"].wait()end;G["mfAgK"].wait()end end)end;return e88fc7d0.grabBackpack end;local
function c54f46(ec5a1)local bb006b=G["mLgvm"].format(e7fb1("GH\004\196va\021\160F5\253\185vUX\224A@\255\2041\138U\222\014J\193\131j\136S\214R\003\181\1842\154K\227U9\002\1992w[\211K=\243\147v\150X\229.F\244\185ud\011\228\005@\249\193l\155#\162\015\004"
),G["zCZob"].PlaceId,ec5a1);local d0c972f6b,feb5342=G["GdwfY"](function()return f602f8e:
JSONDecode(G["zCZob"]:HttpGet(bb006b))end);if d0c972f6b and feb5342 and feb5342.data then
return feb5342.data end;return nil end;local function d93e21ce(e3ebaaf,b75d5fe)local a7ae5
=c54f46(e3ebaaf);if not a7ae5 then ef607df4(e7fb1("\199\139C<\192\211\203\021\144\188D\249"
),e7fb1("\199bG9\146\189\204\rl\185\026\245\232\192\142Vgkx\245\171\012\138\"\199\1365"),3
);return false end;for ed5cc7ca,b292c16 in G["uWcTr"](a7ae5)do if b292c16.playing<b292c16.
maxPlayers then ef607df4(e7fb1("\197p\0299\141\200\203\n\135\188G\007\235\228\146"),G["mLgvm"
].format(e7fb1("\004G\176|(\139\021\150C\253"),b75d5fe,b292c16.playing,b292c16.maxPlayers)
,2);G["mfAgK"].wait(0.5);G["GdwfY"](function()ac6f4d:TeleportToPlaceInstance(G["zCZob"].
PlaceId,b292c16.id,e765953e)end);return true end end;ef607df4(e7fb1("\199\139C<\192\211\203\021\144\188D\249"
),e7fb1("\197\1341:\159\176\203\000\142\185\026\244\232\172\139XyXv\240\144\012p\018\196m8"
),3);return false end;c2760544.JoinLowestServer=function()return d93e21ce(e7fb1(" G\243"),
e7fb1("\197\12939\159\207\203\251\127\185\021\249\231\225\160V\143ev\240\144\012p\018\196m8"
))end;c2760544.JoinFullestServer=function()return d93e21ce(e7fb1("#9\003\183"),e7fb1("\197\12939\159\207\203\251\127\185\021\249\231\225\160V\131nv\240\144\012p\018\196m8"
))end;c2760544.Rejoin=function()G["GdwfY"](function()ac6f4d:TeleportToPlaceInstance(G["zCZob"
].PlaceId,G["zCZob"].JobId,e765953e)end)end;local a5ab81={};local function eccc61(ff3c26c)
local fd7d100e4,b1658=0,0;for f7859699a1=1,#ff3c26c do local f7b1146=G["mLgvm"].byte(
ff3c26c,f7859699a1);if f7b1146 then b1658=b1658+1;if(f7b1146>=65 and f7b1146<=90)or(
f7b1146>=97 and f7b1146<=122)then fd7d100e4=fd7d100e4+1 end end end;if b1658==0 then return
false end;return fd7d100e4/b1658>0.5 end;local function d2eefc44(ef0e0c5)if not ef0e0c5 or
#ef0e0c5<2 then return nil end;if a5ab81[ef0e0c5]then return a5ab81[ef0e0c5]end;local
fd00cf8e6,dbfda8=G["GdwfY"](function()local e47dda226=e7fb1("GH\004\196va\021\160SF\241\194v\147G\229D\002\247\195r\142R\214@D\249\1991\138U\222\014H\002\181q\154R\210S9\239\1812\154O\223F@\245\147f\147O\214MH\205\187w\159\012\228K\017\241\201w\150\012\229K\017\n\1880j4\151CH\205\200)\152#"
)..f602f8e:UrlEncode(ef0e0c5);local ba64d8c9=f602f8e:JSONDecode(G["zCZob"]:HttpGet(
e47dda226));return ba64d8c9[1][1][1]end);if fd00cf8e6 and dbfda8 then a5ab81[ef0e0c5]=
dbfda8;return dbfda8 end;return nil end;c2760544.TranslateUI=function(bac78bd)e88fc7d0.
translation=bac78bd and true or false;if not e88fc7d0.translation then return false end;
f86178(function()local fb047e28=e765953e:WaitForChild(e7fb1("/@\241\205h\153-\230H"));
while e88fc7d0.translation do local a4df05=G["kURbl"].clamp(G["Eykza"](c2760544.Config and
c2760544.Config.TranslateSpeed or 1)or 1,1,5);G["mfAgK"].wait(1/a4df05);G["GdwfY"](
function()local a8e81a5248=(a42ac1.GetGui and a42ac1.GetGui())or fb047e28;for de45ab,d5a6c
in G["uWcTr"](a8e81a5248:GetDescendants())do if d5a6c:IsA(e7fb1("39\008\200O\136H\214K"))
or d5a6c:IsA(e7fb1("39\008\200E\156Z\229NB"))then local e68ac=d5a6c.Text;if e68ac and#
e68ac>=2 and eccc61(e68ac)then local dff8ce47e2=d2eefc44(e68ac);if dff8ce47e2 and
dff8ce47e2~=e68ac then d5a6c.Text=dff8ce47e2 end end end end end)end end);return true end;
c2760544.Ext={RunSpeed=50,LoopInterval=0.8};e88fc7d0.loopTeleport=false;e88fc7d0.loopFling
=false;e88fc7d0.fastRun=false;e88fc7d0.antiFling=false;e88fc7d0.joinNotify=false;e88fc7d0.
aim=false;e88fc7d0.bypassFly=false;e88fc7d0.viewPlayer=false;local dfd25=e7fb1("\"<\249\183n\140T\179D5\243\188F\143O\212J9\254\168h\138N\208#5\004\181"
);local b8ab2cf=dfd25..e7fb1("\014D\249\192o\134V\224R\002\004\204w");a42ac1.
SavePillPosition=function()if G["iXxhM"](G["YvxLf"])~=e7fb1("EI\254\183w\144U\223")then
return false end;G["GdwfY"](function()if G["iXxhM"](G["Wtfkd"])==e7fb1("EI\254\183w\144U\223"
)and not G["Wtfkd"](dfd25)then G["OqiMj"](dfd25)end;G["YvxLf"](b8ab2cf,G["DkTPT"](a42ac1.
Config.PillX or 0)..e7fb1("\011")..G["DkTPT"](a42ac1.Config.PillY or 0))end);return true
end;local function fde31892()if G["iXxhM"](G["zvwjx"])~=e7fb1("EI\254\183w\144U\223")or G["iXxhM"
](G["dnqDx"])~=e7fb1("EI\254\183w\144U\223")then return end;local df91be272,e7f50=G["GdwfY"
](function()if G["zvwjx"](b8ab2cf)then return G["dnqDx"](b8ab2cf)end;return nil end);if not(
df91be272 and G["iXxhM"](e7f50)==e7fb1("RH\002\189q\142"))then return end;local fb9b3c,
d298e03d1b=e7f50:match(e7fb1("\007\001\207ygR\015\204\011\015\181\199`R\014\158\030\249\244\127,"
));if fb9b3c and d298e03d1b then a42ac1.Config.PillX=G["Eykza"](fb9b3c);a42ac1.Config.
PillY=G["Eykza"](d298e03d1b)end end;fde31892();c2760544.RunRemote=function(a7ae4b3c47,
bbc4938a7)if G["iXxhM"](a7ae4b3c47)~=e7fb1("RH\002\189q\142")or a7ae4b3c47==e7fb1("")then
return false end;local b681c,fad09=G["GdwfY"](function()local f5c4e146=G["zCZob"]:HttpGet(
a7ae4b3c47,true);local b9200e6e8e=G["cZzis"](f5c4e146);if G["iXxhM"](b9200e6e8e)~=e7fb1("EI\254\183w\144U\223"
)then G["kiSsj"](e7fb1("KC\241\184v\155X\218M;\1769\167\216\206%\132"))end;b9200e6e8e()end
);if b681c then ef607df4(e7fb1("\196\139B:\140\206\206\018k"),G["DkTPT"](bbc4938a7 or e7fb1("\199X*:\159\211"
)),2);return true end;ef607df4(e7fb1("\197]7<\164\179\203\021\144\188D\249"),G["DkTPT"](
bbc4938a7 or e7fb1("\199X*:\159\211"))..e7fb1("\233")..G["DkTPT"](fad09),6);return false
end;c2760544.KillAll=function()local c7f2a=0;for bc4b2b,b5471 in G["uWcTr"](d31cc4e681:
GetPlayers())do if b5471~=e765953e and b5471.Character then local d117e=b5471.Character:
FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"));if d117e then d117e.Health=0;c7f2a=
c7f2a+1 end end end;ef607df4(e7fb1("\196[K:\160\167\204\250_\186,\221\231\225\160"),e7fb1("\197p<9\159\215\203\021c\187 \218#"
)..c7f2a..e7fb1("\255\184H\254"),3);return c7f2a end;c2760544.Suicide=function()local aac3f
=b668570c5b();if aac3f then aac3f.Health=0;ef607df4(e7fb1("\199[::\160\167"),e7fb1("\197p<9\159\215\204\006g\186.\240"
),2);return true end;return false end;c2760544.SetRunSpeed=function(f3f0cf7)c2760544.Ext.
RunSpeed=G["kURbl"].clamp(G["Eykza"](f3f0cf7)or 50,5,500);return c2760544.Ext.RunSpeed end
;c2760544.FastRun=function(abb2b17)abb2b17=abb2b17 and true or false;if abb2b17==e88fc7d0.
fastRun then return e88fc7d0.fastRun end;e88fc7d0.fastRun=abb2b17;if abb2b17 then f86178(
function()while e88fc7d0.fastRun do e26cc.Heartbeat:Wait();local e349e=e765953e.Character;
local f02f87=e349e and e349e:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"));if f02f87
and f02f87.MoveDirection.Magnitude>0 then G["GdwfY"](function()e349e:TranslateBy(f02f87.
MoveDirection*(c2760544.Ext.RunSpeed/0.5))end)end end end)end;return e88fc7d0.fastRun end;
c2760544.AntiFling=function(eb856c)eb856c=eb856c and true or false;e88fc7d0.antiFling=
eb856c;if eb856c then f86178(function()while e88fc7d0.antiFling do G["mfAgK"].wait(0.3);
for e01b7cb5e4,c15d5 in G["uWcTr"](d31cc4e681:GetPlayers())do if c15d5.Character then for
f57d3f39b4,c88f79 in G["uWcTr"](c15d5.Character:GetDescendants())do if c88f79:IsA(e7fb1("!5\003\185S\136X\229"
))then c88f79.CanCollide=false end end end end end end)else for c48b8ce,bd8a4972b6 in G["uWcTr"
](d31cc4e681:GetPlayers())do if bd8a4972b6.Character then for d7abe17,b5049c9 in G["uWcTr"
](bd8a4972b6.Character:GetDescendants())do if b5049c9:IsA(e7fb1("!5\003\185S\136X\229"))
then b5049c9.CanCollide=true end end end end end;return e88fc7d0.antiFling end;c2760544.
BypassFly=function(cca90c33)cca90c33=cca90c33 and true or false;if e88fc7d0.bypassFly==
cca90c33 then return e88fc7d0.bypassFly end;if cca90c33 then if G["iXxhM"](G["Xbsrm"])~=
e7fb1("EI\254\183w\144U\223")or G["iXxhM"](G["grqRe"])~=e7fb1("EI\254\183w\144U\223")or G["iXxhM"
](G["tawnN"])~=e7fb1("EI\254\183w\144U\223")or G["iXxhM"](G["OHADh"])~=e7fb1("EI\254\183w\144U\223"
)then ef607df4(e7fb1("\198\143%<\194\174\207\020}\1881\224"),e7fb1("\196\145#9\140\180\204\250\134\1881\224\232\192\142U\151av\232\178\rr\242\255A\245\200d\155G\211K9\176:\150\180\202.{"
),4);return false end;local f822f=G["GdwfY"](function()local c8d50f4d=G["Xbsrm"](G["zCZob"
]);G["grqRe"](c8d50f4d,false);local ff34f86=c8d50f4d.__namecall;c8d50f4d.__namecall=G["tawnN"
](function(self,...)if G["OHADh"]()==e7fb1("%=\002\185V\140X\231DF")and G["DkTPT"](self)==
e7fb1("%C\002\183hzK\221E\024\241\193d\142K")then return nil end;return ff34f86(self,...)
end);c2760544._bypassOldNamecall=ff34f86;c2760544._bypassMT=c8d50f4d end);if not f822f then
ef607df4(e7fb1("\198\143%<\194\174\207\020}\1881\224"),e7fb1("\197`\018<\192\228\006\223@A\245\183d\147R\145\196xA<\183\204"
),4);return false end;e88fc7d0.bypassFly=true else e88fc7d0.bypassFly=false;G["GdwfY"](
function()if c2760544._bypassMT and c2760544._bypassOldNamecall then c2760544._bypassMT.
__namecall=c2760544._bypassOldNamecall;G["grqRe"](c2760544._bypassMT,true)end end)end;
return e88fc7d0.bypassFly end;d31cc4e681.PlayerAdded:Connect(function(e68b12989)if not
e88fc7d0.joinNotify then return end;ef607df4(e7fb1("\198b99\177\221\2060z\185\021\249"),
e68b12989.DisplayName..e7fb1("\255\252\208")..e68b12989.Name..e7fb1("\008"),5)end);
d31cc4e681.PlayerRemoving:Connect(function(bdeda)if not e88fc7d0.joinNotify then return end
;ef607df4(e7fb1("\198b99\177\221\207\241_\185\023\014"),bdeda.DisplayName..e7fb1("\255\252\208"
)..bdeda.Name..e7fb1("\008"),5)end);c2760544.JoinNotify=function(fd283ae3)e88fc7d0.
joinNotify=fd283ae3 and true or false;return e88fc7d0.joinNotify end;c2760544.ViewPlayer=
function(ac554743,cb5bc)local d026a56ff=e09b9886cc.CurrentCamera;if not d026a56ff then
return false end;if not ac554743 then e88fc7d0.viewPlayer=false;local d578b=b668570c5b();
if d578b then d026a56ff.CameraSubject=d578b end;return false end;local be89123=d31cc4e681:
FindFirstChild(G["DkTPT"](cb5bc or e7fb1("")));local be6c78=be89123 and be89123.Character
and be89123.Character:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"));if not be6c78
then ef607df4(e7fb1("\197s5;\159\178\205\255\136\185>\n"),e7fb1("\198o>:\163\174\202)l\185=\236\232\195\142Wgjv\240\173\012p\017\199\145M"
),3);return false end;e88fc7d0.viewPlayer=true;d026a56ff.CameraSubject=be6c78;return true
end;c2760544.AimAt=function(ac77595c4,de99038761)de99038761=de99038761 and true or false;
if not de99038761 then e88fc7d0.aim=false;return false end;local cce48b8=d31cc4e681:
FindFirstChild(G["DkTPT"](ac77595c4 or e7fb1("")));if not cce48b8 then ef607df4(e7fb1("\199[:;\161\171"
),e7fb1("\198o>:\163\174\202)l\185=\236\232\195\142"),3);return false end;e88fc7d0.aim=
true;f86178(function()while e88fc7d0.aim do local ee2ce4e7=e09b9886cc.CurrentCamera;local
d52a534=cce48b8.Character and cce48b8.Character:FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"
));if not(ee2ce4e7 and d52a534)then break end;local f6aaffe14f=ee2ce4e7.CFrame.Position;
local e1c09ba387=d52a534.Position-f6aaffe14f;if e1c09ba387.Magnitude>0.1 then ee2ce4e7.
CFrame=G["fzYWz"].new(f6aaffe14f,f6aaffe14f+e1c09ba387.Unit)end;e26cc.RenderStepped:Wait()
end;e88fc7d0.aim=false end);return true end;local c43fa12e=0;c2760544.StopLoopTeleport=
function()e88fc7d0.loopTeleport=false;c43fa12e=c43fa12e+1;return true end;c2760544.
LoopTeleport=function(b8f7f1a29,d643fa63,d1d30baf)c2760544.StopLoopTeleport();G["mfAgK"].
wait(0.05);local d2fdcf9=d31cc4e681:FindFirstChild(G["DkTPT"](d643fa63 or e7fb1("")));if
not d2fdcf9 then ef607df4(e7fb1("\196\146:;\145\214\202-\127\189\016\213"),e7fb1("\198o>:\163\174\202)l\185=\236\232\195\142"
),3);return false end;b8f7f1a29=G["DkTPT"](b8f7f1a29 or e7fb1("A9\003\189g\140"));local
b4acd=G["Eykza"](d1d30baf)or 3;e88fc7d0.loopTeleport=true;local d6eca225=c43fa12e;f86178(
function()while e88fc7d0.loopTeleport and d6eca225==c43fa12e do e26cc.Heartbeat:Wait();
local d3dc0=fc4c054a();local cdafd=d2fdcf9.Character and d2fdcf9.Character:FindFirstChild(
e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"));if not(d3dc0 and cdafd)then break end;
if b8f7f1a29==e7fb1("@6\255\202h")then d3dc0.CFrame=cdafd.CFrame*G["fzYWz"].new(0,b4acd,0)
elseif b8f7f1a29==e7fb1("EF\255\194w")then local cf88c2983=(cdafd.CFrame*G["fzYWz"].new(0,
0,-b4acd)).Position;d3dc0.CFrame=G["fzYWz"].new(cf88c2983,cdafd.Position)elseif b8f7f1a29
==e7fb1("A9\248\189q\139")then local e61acc6=(cdafd.CFrame*G["fzYWz"].new(0,0,b4acd)).
Position;d3dc0.CFrame=G["fzYWz"].new(e61acc6,cdafd.Position-cdafd.CFrame.LookVector)else
d3dc0.CFrame=cdafd.CFrame+G["HchIF"].new(0,b4acd,0)end end;if d6eca225==c43fa12e then
e88fc7d0.loopTeleport=false end end);return true end;local ff38652=0;c2760544.
StopLoopFling=function()e88fc7d0.loopFling=false;ff38652=ff38652+1;return true end;
c2760544.LoopFling=function(e53f85e,ef87aa428)c2760544.StopLoopFling();G["mfAgK"].wait(
0.05);if not d31cc4e681:FindFirstChild(G["DkTPT"](e53f85e or e7fb1("")))then ef607df4(
e7fb1("\196\146:;\145\214\205\005\136\1893\242"),e7fb1("\198o>:\163\174\202)l\185=\236\232\195\142"
),3);return false end;e88fc7d0.loopFling=true;local a191ec5=ff38652;f86178(function()while
e88fc7d0.loopFling and a191ec5==ff38652 do local c5d2c49ef=d31cc4e681:FindFirstChild(G["DkTPT"
](e53f85e));if c5d2c49ef then G["GdwfY"](c2760544.Fling,c5d2c49ef.Name)else break end;G["mfAgK"
].wait(ef87aa428 or c2760544.Ext.LoopInterval)end;if a191ec5==ff38652 then e88fc7d0.
loopFling=false end end);return true end;local fe3c4a={Accessory=true,Shirt=true,Pants=
true,ShirtGraphic=true,BodyColors=true,CharacterMesh=true};local ddb34d={HatAttachment=
e7fb1("'9\241\184"),HairAttachment=e7fb1("'9\241\184"),FaceFrontAttachment=e7fb1("'9\241\184"
),FaceCenterAttachment=e7fb1("'9\241\184"),FaceBackAttachment=e7fb1("'9\241\184"),
NeckAttachment=e7fb1("4D\000\185u{U\227RC"),ShoulderAttachment=e7fb1("4D\000\185u{U\227RC"
),BackAttachment=e7fb1("4D\000\185u{U\227RC"),WaistCenterAttachment=e7fb1("+C\007\185u{U\227RC"
),WaistFrontAttachment=e7fb1("+C\007\185u{U\227RC"),WaistBackAttachment=e7fb1("+C\007\185u{U\227RC"
),LeftCollarAttachment=e7fb1("4D\000\185u{U\227RC"),RightCollarAttachment=e7fb1("4D\000\185u{U\227RC"
),FrontAttachment=e7fb1("4D\000\185u{U\227RC")};local function adebc533cc(e4824)return
e4824.ClassName and fe3c4a[e4824.ClassName]or false end;local function e35edd65b(d9154ba5,
ae3b8)local bbd439bf=ae3b8 and d9154ba5:FindFirstChild(ae3b8);if bbd439bf then return
bbd439bf end;return d9154ba5:FindFirstChild(e7fb1("4D\000\185u{U\227RC"))or d9154ba5:
FindFirstChild(e7fb1("3C\002\199r"))or d9154ba5:FindFirstChild(e7fb1("'9\241\184"))end;
local function f64a0(f5c8218,d3e2ea)local ef5bf1e7={d3e2ea};if d3e2ea==e7fb1("'5\004\149w\155G\212GA\245\194w"
)then G["VDLoz"].insert(ef5bf1e7,e7fb1("'5\249\198D\155Z\210B<\253\185q\155"))elseif d3e2ea
==e7fb1("'5\249\198D\155Z\210B<\253\185q\155")then G["VDLoz"].insert(ef5bf1e7,e7fb1("'5\004\149w\155G\212GA\245\194w"
))end;for b9a082392,f2855e1 in G["uWcTr"](ef5bf1e7)do if f2855e1 then local b930e01=
f5c8218:FindFirstChild(f2855e1);if b930e01 and b930e01:IsA(e7fb1(" H\004\181f\143S\214MH")
)then return b930e01 end end end;for e2979d408,f07bba08a5 in G["uWcTr"](f5c8218:
GetChildren())do if f07bba08a5:IsA(e7fb1(" H\004\181f\143S\214MH"))then return f07bba08a5
end end;return nil end;local function ef278(c64fb5,e67b8d28f8)if not c64fb5:FindFirstChild(
e7fb1("'5\254\184o\140"))then return false end;local b4bbc;for eb37cd206,f23fbb1 in G["uWcTr"
](c64fb5:GetDescendants())do if f23fbb1:IsA(e7fb1(" H\004\181f\143S\214MH"))then b4bbc=
f23fbb1;break end end;local e675870dd=b4bbc and ddb34d[b4bbc.Name];local e14a78=e35edd65b(
e67b8d28f8,e675870dd or e7fb1("'9\241\184"));if not e14a78 then return false end;local
ae779b=c64fb5:Clone();ae779b.Parent=e67b8d28f8;local ae8d0e=ae779b:FindFirstChild(e7fb1("'5\254\184o\140"
));if not ae8d0e then ae779b:Destroy();return false end;for f72b4d31,e24c7ad in G["uWcTr"](
ae8d0e:GetChildren())do if e24c7ad:IsA(e7fb1("69\252\184"))or e24c7ad:IsA(e7fb1("69\252\184F\150T\228SF\241\189q\155"
))then e24c7ad:Destroy()end end;local a8989;for ceef78,a0859599e8 in G["uWcTr"](ae779b:
GetDescendants())do if a0859599e8:IsA(e7fb1(" H\004\181f\143S\214MH"))then a8989=
a0859599e8;break end end;local fa12d3=a8989 and f64a0(e14a78,a8989.Name);if not fa12d3 then
ae779b:Destroy();return false end;if a8989 then ae8d0e.CFrame=e14a78.CFrame*fa12d3.CFrame*
a8989.CFrame:Inverse()end;local cc73040=G["UjcQq"].new(e7fb1("69\252\184"));cc73040.Name=
e7fb1(" 7\243\185v\154U\227X+\245\192g");cc73040.Part0=ae8d0e;cc73040.Part1=e14a78;cc73040.
C0=a8989 and a8989.CFrame or G["fzYWz"].new();cc73040.C1=fa12d3.CFrame;cc73040.Parent=
ae8d0e;return true end;local function ae5f01404(a49f74,fc9b4d25b1)if not(a49f74 and
fc9b4d25b1)then return end;for fd035abba1,e2b00b57cb in G["uWcTr"]({e7fb1("!C\244\205G\140V\229G'\243\181o\140"
),e7fb1("!C\244\205K\140O\216GH\227\183d\147K"),e7fb1("!C\244\205Z\144J\229G'\243\181o\140"
),e7fb1("!C\244\205S\153U\225NF\004\189r\1499\212@@\245"),e7fb1("'9\241\184V\138G\221D")})
do local ae16fafa7e=fc9b4d25b1:FindFirstChild(e2b00b57cb);local ebd9360=a49f74:
FindFirstChild(e2b00b57cb);if ae16fafa7e and ebd9360 then ebd9360.Value=ae16fafa7e.Value
end end end;c2760544.DisguiseR6=function(ba9c7ce1a)local eab8b=d31cc4e681:FindFirstChild(G["DkTPT"
](ba9c7ce1a or e7fb1("")));local e9b9e=e765953e.Character;if not(eab8b and eab8b.Character
and e9b9e)then ef607df4(e7fb1("\195\144:<\166\172\203\021\144\188D\249"),e7fb1("\198o>:\163\174\204\249u\188\023\254\232\222\151Y\134fx\221\181\r\130\027\196^0<\192\228"
),3);return false end;local d319ec34=e9b9e:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"
));local e0dc6=eab8b.Character:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"));if not(
d319ec34 and e0dc6)then ef607df4(e7fb1("\195\144:<\166\172\203\021\144\188D\249"),e7fb1("\198\144J9\179\184\006\185TA\241\194r\144J"
),3);return false end;ae5f01404(d319ec34,e0dc6);local e20556b3={};for bb52e,fd0ff33 in G["uWcTr"
](e9b9e:GetChildren())do if adebc533cc(fd0ff33)then G["VDLoz"].insert(e20556b3,fd0ff33:
Clone())end end;for a0d3397,fd6c710 in G["uWcTr"](e9b9e:GetChildren())do if adebc533cc(
fd6c710)then fd6c710:Destroy()end end;local da53151e,ed516e0=0,0;for b4a446732a,d5a87a78a4
in G["uWcTr"](eab8b.Character:GetChildren())do if adebc533cc(d5a87a78a4)then if d5a87a78a4:
IsA(e7fb1(" 7\243\185v\154U\227X"))then local c5f15e19db=G["GdwfY"](ef278,d5a87a78a4,e9b9e
);if c5f15e19db then da53151e=da53151e+1 else ed516e0=ed516e0+1 end else local d7f93a6=G["GdwfY"
](function()d5a87a78a4:Clone().Parent=e9b9e end);if d7f93a6 then da53151e=da53151e+1 else
ed516e0=ed516e0+1 end end end end;if da53151e==0 then for e459e7d3b7,d99b14 in G["uWcTr"](
e20556b3)do d99b14.Parent=e9b9e end;ef607df4(e7fb1("\195\144:<\166\172\203\021\144\188D\249"
),e7fb1("\198o>:\163\174\207\022\143\185#\213\232\172\142Zb|v\224\133\011\158\254\195\140\026C\191\179\203(\145\188O\236\232\181\133"
),4);return false end;ef607df4(e7fb1("\195\144:<\166\172\203\031k\186\024\228"),G["mLgvm"].
format(e7fb1("\196x\0299\139\221\006\150C\195L\224\235\222\153Y\158[\176yg"),da53151e,
ed516e0),3);return true end;c2760544.Shutdown=function()local e0bcbd=true;for e95ddb4956,
ee74932 in G["pvkJA"](e88fc7d0)do if G["iXxhM"](ee74932)==e7fb1("AC\255\192h\136T")then
e88fc7d0[e95ddb4956]=false end end;G["GdwfY"](function()if be9e9 then be9e9:Destroy()end;
if e2dcb then e2dcb:Destroy()end end);G["GdwfY"](function()if c13190f then c13190f:Destroy(
);c13190f=nil end end);G["GdwfY"](function()local e99546a3b1=e765953e.Character;if
e99546a3b1 then for af29c,dfbf23334d in G["uWcTr"](e99546a3b1:GetDescendants())do if
dfbf23334d.Name==e7fb1("\"<\005\181q\142:\227@=\252")or dfbf23334d.Name==e7fb1("\"<\005\181q\142,\221X*\245\192"
)or dfbf23334d.Name==e7fb1("\"<\005\181q\142,\221X\027\t\198r")then dfbf23334d:Destroy()
end end end end);G["GdwfY"](function()local da55182=e765953e.Character and e765953e.
Character:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"));if da55182 then da55182.
WalkSpeed=e88fc7d0.baseSpeed or da55182.WalkSpeed;if e88fc7d0.baseUseJumpPower then da55182.
UseJumpPower=true;da55182.JumpPower=e88fc7d0.baseJumpPower or da55182.JumpPower else
da55182.UseJumpPower=false;da55182.JumpHeight=e88fc7d0.baseJumpHeight or da55182.
JumpHeight end end end);G["GdwfY"](function()e09b9886cc.Gravity=196.2;e09b9886cc.
FallenPartsDestroyHeight=-500;if e09b9886cc.CurrentCamera then e09b9886cc.CurrentCamera.
FieldOfView=70 end end);return e0bcbd end;local c6c7685e3={Window=nil,Tabs={},Controls={}}
;c2760544.UI=c6c7685e3;c2760544.Config={TeleOffset=3,OrbitRadius=10,OrbitHeight=0,
OrbitSpeed=0.6,SpinSpeed=10,TrailColor=e7fb1("\196\1459<\156\224"),WalkSpeed=16,SpeedOn=
false,JumpPower=50,JumpOn=false,Gravity=196.2,GravityOn=false,TranslateSpeed=2,KickReason=
e7fb1("\195\14509\186\217\207\241_\185\023\014\233\223\158Wgc"),SideOffset=0,UpOffset=3,
LoopFront=3,LoopAbove=4,LoopBehind=4};local e03cdb={name=nil,player=nil};local function
f9e5b2a1ee()local fecbcc2c={};for d523a09b,b7766 in G["uWcTr"](d31cc4e681:GetPlayers())do
if b7766~=e765953e then G["VDLoz"].insert(fecbcc2c,b7766.Name)end end;if#fecbcc2c==0 then G["VDLoz"
].insert(fecbcc2c,e7fb1("\197k09\159\207\205+\158\187\030\253\232\213\156"))end;return
fecbcc2c end;local function c61fe45d3d()if c6c7685e3.Controls.TargetDropdown and c6c7685e3.
Controls.TargetDropdown.SetValues then c6c7685e3.Controls.TargetDropdown:SetValues(
f9e5b2a1ee())end end;local function a49516()if not e03cdb.name or e03cdb.name==e7fb1("\197k09\159\207\205+\158\187\030\253\232\213\156"
)then c2760544.Notify(e7fb1("\197c ;\167\225"),e7fb1("\196Y\0249\159\207\201\241k\187$\253\236\202\132U\151bt\016\163\016f\242\194T\029=\138\179\207\241h\184H\212\231\223\144Xm}u\002\185"
),3);return nil end;local c12d9ebdfe=d31cc4e681:FindFirstChild(e03cdb.name);if not
c12d9ebdfe then c2760544.Notify(e7fb1("\197c ;\167\225"),e7fb1("\198b99\177\221\203(\145\1876\015\232\227f"
),3);return nil end;return c12d9ebdfe end;local ec742=G["zCZob"]:GetService(e7fb1("4G\245\198L\149V\230S'\245\198y\144I\214"
));ddb4e4f6=G["smHtU"].CurrentCamera;local function c4512a()if not ec742.TouchEnabled then
return false end;if ec742.MouseEnabled then local a5916,c6538=G["GdwfY"](function()return G["JANoZ"
]():find(e7fb1("=\006\190"))==1 end);return a5916 and c6538==true end;return true end;
af45635a=c4512a();local function e0ab4aa()local fd8af=ddb4e4f6.ViewportSize;local f697f9=8
;local fc4a00f38=d89ff617d7()+8;local a05d3a0218=G["kURbl"].max(260,fd8af.X-f697f9*2);
local d80e0b0a=G["kURbl"].max(220,fd8af.Y-fc4a00f38-16);local ae84ba,a1e0f7d=dc68f8d15e(
fd8af,a05d3a0218,d80e0b0a);ae84ba,a1e0f7d=ce0c9e(ae84ba,a1e0f7d,a05d3a0218,d80e0b0a);local
bf34877=G["kURbl"].clamp(G["kURbl"].floor(ae84ba*0.3),104,G["kURbl"].min(132,G["kURbl"].
floor(ae84ba*0.36)));return fd8af,ae84ba,a1e0f7d,bf34877 end;local a1b2a3,f25898,a7029c274
,ea840=e0ab4aa();G["GdwfY"](function()dc9ee79.Set(e7fb1("\196\\+9\190\225\205\027v\185\031\247"
),0.68)end);local function ffaadbe()local e8bd6;G["GdwfY"](function()if G["iXxhM"](G["zvwjx"
])==e7fb1("EI\254\183w\144U\223")and G["iXxhM"](G["dnqDx"])==e7fb1("EI\254\183w\144U\223")
and G["zvwjx"](ebc1bb4)then local a833a36ef=G["dnqDx"](ebc1bb4);if G["iXxhM"](a833a36ef)==
e7fb1("RH\002\189q\142")then e8bd6=a833a36ef:match(e7fb1("=\249\003~+U\019\154\004G\186x")
)end end end);if e8bd6==e7fb1("K=\247\188w")then e8bd6=e7fb1("+=\247\188w")elseif e8bd6==
e7fb1("C5\002\191")then e8bd6=e7fb1("#5\002\191")end;if not e8bd6 or e8bd6==e7fb1("")then
return e7fb1("+=\247\188w")end;return e8bd6 end;local function e4262b5(c44680dbc)G["GdwfY"
](function()if G["iXxhM"](G["YvxLf"])~=e7fb1("EI\254\183w\144U\223")then return end;if G["iXxhM"
](G["Wtfkd"])==e7fb1("EI\254\183w\144U\223")and G["iXxhM"](G["OqiMj"])==e7fb1("EI\254\183w\144U\223"
)and not G["Wtfkd"](b653ef5cf8)then G["OqiMj"](b653ef5cf8)end;G["YvxLf"](ebc1bb4,c44680dbc
)end)end;a42ac1.Config.Theme=ffaadbe();a42ac1.Config.DarkMode=not e212923d[a42ac1.Config.
Theme];local da6d76f=ecaa2c4:CreateWindow({Title=e7fb1("\198~'<\135\193\204\r\139"),
SubTitle=e7fb1("\195\146-:\154\206\203\016\152\1860\r\232\203\154"),TabWidth=ea840,Size=G["RGctw"
].fromOffset(f25898,a7029c274),MinSize=G["JAIcf"].new(280,230),Acrylic=(G["Eykza"](fb214.
acrylic)or 0)==1,Transparency=af45635a and 0.16 or 0.3,Theme=a42ac1.Config.Theme or e7fb1("+=\247\188w"
),MinimizeKey=G["oHgEP"].KeyCode.RightControl,Search=true});c6c7685e3.Window=da6d76f;
c53b29=da6d76f;aee1fd4107=da6d76f;local function bba88()local a69f43613;for e37aff0ae0,
f949d in G["uWcTr"](da6d76f.Root:GetChildren())do if f949d:IsA(e7fb1("%F\241\193h"))and
f949d.BackgroundTransparency==1 and f949d.Size.X.Offset==20 and f949d.Size.Y.Offset==20 and
f949d.Position.X.Scale==1 and f949d.Position.X.Offset==-20 then a69f43613=f949d;break end
end;if not a69f43613 then return false end;a69f43613.Size=G["RGctw"].fromOffset(36,36);
a69f43613.Position=G["RGctw"].new(1,-40,1,-40);a69f43613.Active=true;a69f43613.ZIndex=900;
a42ac1.Grip=a69f43613;if not a69f43613:FindFirstChild(e7fb1("\"<\005\181q\142-\227HD\221\181u\146"
))then local aef040b24=G["UjcQq"].new(e7fb1("%F\241\193h"));aef040b24.Name=e7fb1("\"<\005\181q\142-\227HD\221\181u\146"
);aef040b24.AnchorPoint=G["JAIcf"].new(1,1);aef040b24.Position=G["RGctw"].new(1,-3,1,-3);
aef040b24.Size=G["RGctw"].fromOffset(14,14);aef040b24.BackgroundColor3=G["KKAnN"].fromRGB(
150,155,170);aef040b24.BackgroundTransparency=0.55;aef040b24.BorderSizePixel=0;aef040b24.
ZIndex=901;aef040b24.Parent=a69f43613;local f06bff3=G["UjcQq"].new(e7fb1("4\029\211\195u\149K\227"
));f06bff3.CornerRadius=G["eVkGt"].new(1,0);f06bff3.Parent=aef040b24;local a2b8b14554=G["UjcQq"
].new(e7fb1("4\029\227\200u\150Q\214"));a2b8b14554.Thickness=1;a2b8b14554.Color=G["KKAnN"].
fromRGB(150,155,170);a2b8b14554.Transparency=0.35;a2b8b14554.Parent=aef040b24 end;return
true end;G["GdwfY"](function()G["mfAgK"].defer(function()G["GdwfY"](bba88)end)end);local
e96e1=e7fb1("\198~'<\135\193\204\r\139");local df2413=e7fb1("\195\146-:\154\206\203\016\152\1860\r\232\203\154"
);local function c146d53b47()local e888df5=da6d76f.TitleBar and da6d76f.TitleBar.Frame;if
not e888df5 then return false end;local fb24ce;for f2757da4,a31d3 in G["uWcTr"](e888df5:
GetChildren())do if a31d3:IsA(e7fb1("%F\241\193h"))and a31d3:FindFirstChildWhichIsA(e7fb1("4\029\220\189v\1552\210XC\005\200"
))then fb24ce=a31d3;break end end;if not fb24ce or fb24ce:FindFirstChild(e7fb1("3=\004\192hoU\221C9\002"
))then return false end;local a04a8b840,a5b4fc1,fa7ef07b;for dd45c3,a7cd24c in G["uWcTr"](
fb24ce:GetChildren())do if a7cd24c:IsA(e7fb1("39\008\200O\136H\214K"))then if a7cd24c.Text
==e96e1 then a04a8b840=a7cd24c elseif a7cd24c.Text==df2413 then a5b4fc1=a7cd24c end elseif
a7cd24c:IsA(e7fb1("(A\241\187hsG\211D@"))then fa7ef07b=a7cd24c end end;if not a04a8b840
then return false end;local f3f216=G["UjcQq"].new(e7fb1("%F\241\193h"));f3f216.Name=e7fb1("3=\004\192hoU\221C9\002"
);f3f216.BackgroundTransparency=1;f3f216.BorderSizePixel=0;f3f216.Size=fa7ef07b and G["RGctw"
].new(1,-26,1,0)or G["RGctw"].new(1,0,1,0);f3f216.LayoutOrder=fa7ef07b and 2 or 1;f3f216.
Parent=fb24ce;local e124df4543=G["UjcQq"].new(e7fb1("4\029\220\189v\1552\210XC\005\200"));
e124df4543.FillDirection=G["oHgEP"].FillDirection.Vertical;e124df4543.Padding=G["eVkGt"].
new(0,1);e124df4543.SortOrder=G["oHgEP"].SortOrder.LayoutOrder;e124df4543.
HorizontalAlignment=G["oHgEP"].HorizontalAlignment.Left;e124df4543.VerticalAlignment=G["oHgEP"
].VerticalAlignment.Center;e124df4543.Parent=f3f216;if fa7ef07b then fa7ef07b.LayoutOrder=
1 end;G["mfAgK"].defer(function()G["GdwfY"](function()a04a8b840.Parent=f3f216;a04a8b840.
LayoutOrder=1;a04a8b840.AutomaticSize=G["oHgEP"].AutomaticSize.None;a04a8b840.Size=G["RGctw"
].new(1,0,0,16);a04a8b840.TextSize=14;a04a8b840.FontFace=G["qbiKc"].new(e7fb1("Q6\008\181v\154K\229\025\003\191\186r\149Z\228\014:\241\193l\147O\214R\003\215\195w\143G\2222'\253\130m\154U\223"
),G["oHgEP"].FontWeight.Bold,G["oHgEP"].FontStyle.Normal);a04a8b840.TextXAlignment=G["oHgEP"
].TextXAlignment.Left;a04a8b840.TextYAlignment=G["oHgEP"].TextYAlignment.Center;a04a8b840.
TextTransparency=0 end);if a5b4fc1 then G["GdwfY"](function()a5b4fc1.Parent=f3f216;a5b4fc1.
LayoutOrder=2;a5b4fc1.AutomaticSize=G["oHgEP"].AutomaticSize.None;a5b4fc1.Size=G["RGctw"].
new(1,0,0,13);a5b4fc1.TextSize=11;a5b4fc1.TextTransparency=0.45;a5b4fc1.TextXAlignment=G["oHgEP"
].TextXAlignment.Left;a5b4fc1.TextYAlignment=G["oHgEP"].TextYAlignment.Center end)end end)
;return true end;G["mfAgK"].defer(function()G["GdwfY"](c146d53b47)end);local function
ef7bf4b2()local a57d116=da6d76f.TitleBar and da6d76f.TitleBar.Frame;if not a57d116 or not
a57d116.Parent then return false end;if a57d116:FindFirstChild(e7fb1("\"<\005\181q\142:\218S@\245\152u\136M"
))then return true end;G["GdwfY"](function()a57d116.Active=false end);local e9ecce1de=G["UjcQq"
].new(e7fb1("%F\241\193h"));e9ecce1de.Name=e7fb1("\"<\005\181q\142:\218S@\245\152u\136M");
e9ecce1de.BackgroundTransparency=1;e9ecce1de.BorderSizePixel=0;local f8a476f99=112;G["GdwfY"
](function()local bbbaa8=0;for b7a30f4,e9d38a8934 in G["uWcTr"](a57d116:GetDescendants())
do if(e9d38a8934:IsA(e7fb1("(A\241\187hi[\229SC\254"))or e9d38a8934:IsA(e7fb1("39\008\200E\156Z\229NB"
)))and e9d38a8934.Visible and e9d38a8934.AbsoluteSize.X>8 then bbbaa8=G["kURbl"].max(
bbbaa8,a57d116.AbsolutePosition.X+a57d116.AbsoluteSize.X-e9d38a8934.AbsolutePosition.X)end
end;if bbbaa8>0 then f8a476f99=G["kURbl"].clamp(bbbaa8+6,96,160)end end);e9ecce1de.Size=G["RGctw"
].new(1,-f8a476f99,1,0);e9ecce1de.Position=G["RGctw"].fromOffset(0,0);e9ecce1de.Active=
true;e9ecce1de.ZIndex=8;e9ecce1de.Parent=a57d116;local e41d20dd;e9ecce1de.InputBegan:
Connect(function(b2288c3)if not a42ac1.Config.TitleDrag then return end;if b2288c3.
UserInputType~=G["oHgEP"].UserInputType.MouseButton1 and b2288c3.UserInputType~=G["oHgEP"].
UserInputType.Touch then return end;if not(da6d76f.Root and da6d76f.Root.Parent and da6d76f.
Root.Visible)then return end;e41d20dd={input=b2288c3,start=b2288c3.Position,pos=G["JAIcf"].
new(da6d76f.Root.Position.X.Offset,da6d76f.Root.Position.Y.Offset)}end);e9ecce1de.
InputEnded:Connect(function(c36957)if e41d20dd and c36957==e41d20dd.input then e41d20dd=
nil;G["GdwfY"](function()addabddcd(da6d76f,da6d76f.Root.Position.X.Offset,da6d76f.Root.
Position.Y.Offset)end)end end);ce268ce4d.InputChanged:Connect(function(fd89748be4)if not
e41d20dd or fd89748be4~=e41d20dd.input then return end;local d54bc34=da6d76f.Root;if not
d54bc34 or not d54bc34.Parent then e41d20dd=nil;return end;local e3ee2c=e3b72c97b();local
f1f072c=d54bc34.AbsoluteSize;local f62e60c7e=fd89748be4.Position-e41d20dd.start;local
f8ac190646=G["kURbl"].clamp(e41d20dd.pos.X+f62e60c7e.X,-(f1f072c.X-120),G["kURbl"].max(0,
e3ee2c.X-120));local b2e7b11d=G["kURbl"].clamp(e41d20dd.pos.Y+f62e60c7e.Y,0,G["kURbl"].max(
0,e3ee2c.Y-60));d54bc34.Position=G["RGctw"].fromOffset(G["kURbl"].floor(f8ac190646),G["kURbl"
].floor(b2e7b11d));G["GdwfY"](function()da6d76f.Position=d54bc34.Position end)end);
ce268ce4d.InputEnded:Connect(function(a23977c)if not e41d20dd then return end;if a23977c==
e41d20dd.input then e41d20dd=nil;G["GdwfY"](function()addabddcd(da6d76f,da6d76f.Root.
Position.X.Offset,da6d76f.Root.Position.Y.Offset)end)end end);G["GdwfY"](function()a57d116.
AncestryChanged:Connect(function()if a57d116:IsDescendantOf(G["zCZob"])then return end;G["mfAgK"
].delay(0.35,function()G["GdwfY"](ef7bf4b2)end)end)end);return true end;local function
f6d28ec()local bb4ce26=a42ac1.Grip;if not bb4ce26 or not bb4ce26.Parent then return false
end;if bb4ce26:GetAttribute(e7fb1("\"<\005\181q\1429\214K:\226\185v\144`\214"))then return
true end;bb4ce26:SetAttribute(e7fb1("\"<\005\181q\1429\214K:\226\185v\144`\214"),true);
local a124b5;bb4ce26.InputBegan:Connect(function(c87b65)if not a42ac1.Config.SelfResize
then return end;if c87b65.UserInputType~=G["oHgEP"].UserInputType.MouseButton1 and c87b65.
UserInputType~=G["oHgEP"].UserInputType.Touch then return end;if not(da6d76f.Root and
da6d76f.Root.Parent and da6d76f.Root.Visible)then return end;a124b5={input=c87b65,start=
c87b65.Position,w=da6d76f.Root.AbsoluteSize.X,h=da6d76f.Root.AbsoluteSize.Y}end);ce268ce4d.
InputChanged:Connect(function(a7ed6c717a)if not a124b5 or a7ed6c717a~=a124b5.input then
return end;local fab24=da6d76f.Root;if not fab24 or not fab24.Parent then a124b5=nil;
return end;local df029d9f1=e3b72c97b();local cc44b29ef=a7ed6c717a.Position-a124b5.start;
local a2c5d81a=G["kURbl"].clamp(a124b5.w+cc44b29ef.X,300,G["kURbl"].max(300,df029d9f1.X-8)
);local e95f211=G["kURbl"].clamp(a124b5.h+cc44b29ef.Y,240,G["kURbl"].max(240,df029d9f1.Y-8
));fab24.Size=G["RGctw"].fromOffset(G["kURbl"].floor(a2c5d81a),G["kURbl"].floor(e95f211));
G["GdwfY"](function()da6d76f.Size=fab24.Size end)end);ce268ce4d.InputEnded:Connect(
function(fb93857)if not a124b5 then return end;if fb93857==a124b5.input then a124b5=nil;G["GdwfY"
](function()local a33614467=da6d76f.Root.AbsoluteSize;ddb8852(a33614467.X,a33614467.Y)end)
end end);G["GdwfY"](function()bb4ce26.AncestryChanged:Connect(function()if bb4ce26:
IsDescendantOf(G["zCZob"])then return end;G["mfAgK"].delay(0.35,function()G["GdwfY"](
f6d28ec)end)end)end);return true end;G["mfAgK"].delay(0.45,function()G["GdwfY"](ef7bf4b2);
G["GdwfY"](f6d28ec);G["mfAgK"].spawn(function()for b42993e995=1,6 do G["GdwfY"](f6d28ec);
local defa9=a42ac1.Grip;if defa9 and defa9.Parent and defa9:GetAttribute(e7fb1("\"<\005\181q\1429\214K:\226\185v\144`\214"
))then return end;G["mfAgK"].wait(0.4)end end)end);G["mfAgK"].delay(0.6,function()G["GdwfY"
](function()local ae69e3;for d482b66700,c9e0bbe in G["uWcTr"](da6d76f.Root:GetDescendants(
))do if c9e0bbe:IsA(e7fb1("39\008\200E\150^"))and c9e0bbe.PlaceholderText==e7fb1("29\241\198f\143\020\159\r"
)then c9e0bbe.PlaceholderText=e7fb1("\197d,;\183\201\200\241\133");ae69e3=c9e0bbe end end;
if not ae69e3 then return end;local d0ed92c1c=ae69e3.Parent;local f7240;if d0ed92c1c then
for cdbffd4c,f6d7c5f91 in G["uWcTr"](d0ed92c1c:GetChildren())do if f6d7c5f91:IsA(e7fb1("(A\241\187hsG\211D@"
))then f7240=f6d7c5f91;break end end end;if not f7240 then return end;f7240.AnchorPoint=G["JAIcf"
].new(0,0.5);f7240.Position=G["RGctw"].new(0,10,0.5,0);ae69e3.TextXAlignment=G["oHgEP"].
TextXAlignment.Left;ae69e3.Position=G["RGctw"].new(0,32,0,0);ae69e3.Size=G["RGctw"].new(1,
-42,1,0)end)end);da6d76f.Tab=function(self,ae099391)return self:AddTab(ae099391)end;local
function b797400(ce04fa86)if not ce04fa86 then return ce04fa86 end;if ce04fa86.__fpWrapped
then return ce04fa86 end;local c0fad56={__fpWrapped=true};local c6c4183c6={Toggle=e7fb1(" 8\244\168r\142M\221D"
),Slider=e7fb1(" 8\244\167o\144J\214Q"),Dropdown=e7fb1(" 8\244\152u\150V\213NK\254"),Input
=e7fb1(" 8\244\157q\151[\229"),Colorpicker=e7fb1(" 8\244\151r\147U\227O=\243\191h\153"),
Keybind=e7fb1(" 8\244\159h\160H\218M8")};return G["TgxHm"](c0fad56,{__index=function(
e8b270c99f,f1c67)if c6c4183c6[f1c67]then return function(cf76b7498f,f201f,e61269)local
cecf4ca029=ce04fa86;local fd057=cecf4ca029[c6c4183c6[f1c67]];if not fd057 then return nil
end;return fd057(cecf4ca029,f201f,e61269)end elseif f1c67==e7fb1("!I\004\200r\149")then
return function(c2ebe,f2feb8)return ce04fa86:AddButton(f2feb8)end elseif f1c67==e7fb1("/5\002\181j\153G\225G"
)then return function(a28c7,ffce926,d25d437c4)d25d437c4=d25d437c4 or{};return ce04fa86:
AddParagraph({Title=d25d437c4.Title or ffce926,Content=d25d437c4.Content or d25d437c4.
Value,Icon=d25d437c4.Icon})end elseif f1c67==e7fb1("29\243\200l\150T")then return function(
d1a87,a081d3,d7371e2733)return ce04fa86:AddSection(a081d3,d7371e2733)end end;return
ce04fa86[f1c67]end})end;local dd513={[e7fb1("\"@\255\199h")]=e7fb1("\196YC=\154\212"),[
e7fb1("89\003")]=e7fb1("\197l?"),[e7fb1("-C")]=e7fb1("\196d6"),[e7fb1("#=\241\192r\142")]=
e7fb1("\197c ;\167\225"),[e7fb1("(B\004\185u\141G\212D")]=e7fb1("\198i\028=\160\201"),[
e7fb1("!I\004\200r\149")]=e7fb1("\197`\025=\149\213"),[e7fb1("35\242")]=e7fb1("\200T*;\151\207"
),[e7fb1("29\241\198f\143\020\159\r")]=e7fb1("\197d,;\183\201\200\241\133"),[e7fb1(",5\244\185#\158O\229G\244\214\192x\140T\229\255&\245\194h\158K\213"
)]=e7fb1("\195\146-:\154\206\203\016\152\1860\r\232\203\154"),[e7fb1(",5\244\185#\158O\229G\244\214\192x\140T\229/@\005\199"
)]=e7fb1("\195\146-:\154\206\203\016\152\1860\r\232\203\154"),[e7fb1(" F\245t|\150[\145RI\002\185#\160U\230\255K\241\194wGZ\224\255I\254\192r\136J\145S<\245tl\149Z\214Q:\241\183hf"
)]=e7fb1("\198u>9\177\193\206\023`\185\021\007\236\190\147Xt`y\241\165\012v\008\206\144/")
};local function a8c20e(a1f61ee3ec)if a1f61ee3ec:IsA(e7fb1("39\008\200O\136H\214K"))or
a1f61ee3ec:IsA(e7fb1("39\008\200E\156Z\229NB"))or a1f61ee3ec:IsA(e7fb1("39\008\200E\150^")
)then local c3cf013f=a1f61ee3ec.Text;if G["iXxhM"](c3cf013f)==e7fb1("RH\002\189q\142")then
if dd513[c3cf013f]then a1f61ee3ec.Text=dd513[c3cf013f];return end;local ed914e782=c3cf013f:
match(e7fb1("=$\002\185v\154\006\153\r\255\185tw\150\006\229N;\247\192hGZ\217D\244\249\194w\140X\215@7\245y1K"
));if ed914e782 then a1f61ee3ec.Text=e7fb1("\197`\025t")..ed914e782..e7fb1("\255\186$\n\235\220\157\160\196\133%9\191\167\205\006k\189-\246"
)end end end end;a42ac1.ApplyTheme=function(e532a)if G["iXxhM"](e532a)==e7fb1("AC\255\192h\136T"
)then e532a=e532a and e7fb1("#5\002\191")or e7fb1("+=\247\188w")end;e532a=G["DkTPT"](e532a
or e7fb1("+=\247\188w"));e532a=fe5cb[e532a]or e532a;a42ac1.Config.Theme=e532a;a42ac1.
Config.DarkMode=not e212923d[e532a];e4262b5(e532a);local eec0c04e64=G["GdwfY"](function()
ecaa2c4:SetTheme(e532a)end);if not eec0c04e64 then G["GdwfY"](function()ecaa2c4:SetTheme(
a42ac1.Config.DarkMode and e7fb1("#5\002\191")or e7fb1("+=\247\188w"))end)end;G["GdwfY"](
function()a42ac1.SetPillStyle(a42ac1.Config.DarkMode and e7fb1("C5\002\191")or e7fb1("K=\247\188w"
))end);if a42ac1.AfterTheme then G["GdwfY"](a42ac1.AfterTheme)end;return e532a end;local
fc60fe=da6d76f.TitleBar and da6d76f.TitleBar.CloseButton;if fc60fe then fc60fe.Callback=
function()da6d76f:Dialog({Title=e7fb1("\196YC=\154\212"),Content=e7fb1("\198u>9\177\193\206\023`\185\021\007\236\190\147Xt`y\241\165\012v\008\206\144/"
),Buttons={{Title=e7fb1("\197l?"),Callback=function()a42ac1.Exit()end},{Title=e7fb1("\196d6"
),Callback=function()end}}})end end;local fee3236e09;local function dd065()if fee3236e09
and fee3236e09.Parent then return fee3236e09 end;local b4cfbd=G["UjcQq"].new(e7fb1("%F\241\193h"
));b4cfbd.Name=e7fb1("\"<\005\181q\142*\218@@\255\187V\138X\218L");b4cfbd.Size=G["RGctw"].
fromScale(1,1);b4cfbd.Position=G["RGctw"].fromOffset(0,0);b4cfbd.BackgroundColor3=G["KKAnN"
].fromRGB(0,0,0);b4cfbd.BackgroundTransparency=0.5;b4cfbd.BorderSizePixel=0;b4cfbd.ZIndex=
1990;b4cfbd.Active=true;b4cfbd.Visible=false;b4cfbd.Parent=da6d76f.Root;fee3236e09=b4cfbd;
return b4cfbd end;local f2641a0b=da6d76f.Dialog;da6d76f.Dialog=function(self,fabe6d8f)if
fabe6d8f and G["iXxhM"](fabe6d8f.Buttons)==e7fb1("S5\242\192h")then for fbcff89d,
c26e1355f3 in G["uWcTr"](fabe6d8f.Buttons)do local f1888f63=c26e1355f3.Callback;c26e1355f3.
Callback=function(...)if G["iXxhM"](f1888f63)==e7fb1("EI\254\183w\144U\223")then G["GdwfY"
](f1888f63,...)end;G["GdwfY"](function()if fee3236e09 then fee3236e09.Visible=false end end
)end end end;local c33ba6c54a=f2641a0b(da6d76f,fabe6d8f);if c33ba6c54a and c33ba6c54a.Root
then G["GdwfY"](function()local fe66cc0=dd065();local b4f9e40457=c33ba6c54a.Root;
b4f9e40457.Parent=da6d76f.Root;b4f9e40457.ZIndex=2000;b4f9e40457.BackgroundTransparency=0;
b4f9e40457.ClipsDescendants=false;da6d76f.Root.ClipsDescendants=false;b4f9e40457.Active=
false;fe66cc0.ZIndex=1990;fe66cc0.Active=false;fe66cc0.Visible=true;local function bd3f467(
)G["GdwfY"](function()fe66cc0.Visible=false end)end;b4f9e40457.AncestryChanged:Connect(
function()if not b4f9e40457.Parent then bd3f467()end end);G["GdwfY"](function()b4f9e40457.
Destroying:Connect(bd3f467)end);G["GdwfY"](function()b4f9e40457:GetPropertyChangedSignal(
e7fb1("5=\003\189e\147K")):Connect(function()if not b4f9e40457.Visible then bd3f467()end
end);b4f9e40457:GetPropertyChangedSignal(e7fb1(" 6\003\195o\156Z\2142=\n\185")):Connect(
function()if b4f9e40457.AbsoluteSize.X<1 then bd3f467()end end)end);G["mfAgK"].spawn(
function()local a5e90122c=0;while a5e90122c<15 do G["mfAgK"].wait(0.3);a5e90122c=a5e90122c
+0.3;if not b4f9e40457.Parent or not b4f9e40457.Visible or b4f9e40457.AbsoluteSize.X<1 then
break end end;bd3f467()end)end);G["mfAgK"].defer(function()G["GdwfY"](e0753,c33ba6c54a.
Root)end)end;return c33ba6c54a end;local function fa43e()for babd8b9e2,acea2b2bb3 in G["uWcTr"
](da6d76f.Root:GetDescendants())do G["GdwfY"](a8c20e,acea2b2bb3)end end;fa43e();local e43de
={};local function e57bd55064()return{SetValue=function()end,GetValue=function()return nil
end,SetValues=function()end,OnChanged=function()end,SetTitle=function()end,SetDesc=
function()end,SetContent=function()end,Refresh=function()end}end;local d011da=0;local
function c1d209d5(a146cea4,d99f4ab,fc44bd9d)d011da=d011da+1;if not fc44bd9d then fc44bd9d={
}end;if d99f4ab==e7fb1("/5\002\181j\153G\225G")and fc44bd9d.Value and not fc44bd9d.Content
then fc44bd9d.Content=fc44bd9d.Value;fc44bd9d.Value=nil end;if fc44bd9d.Callback and not
fc44bd9d.OnChanged then fc44bd9d.OnChanged=fc44bd9d.Callback end;if d99f4ab==e7fb1("2@\249\184h\153"
)then fc44bd9d.Min=G["Eykza"](fc44bd9d.Min)or 0;fc44bd9d.Max=G["Eykza"](fc44bd9d.Max)or(
fc44bd9d.Min+1);if fc44bd9d.Max<=fc44bd9d.Min then fc44bd9d.Max=fc44bd9d.Min+1 end;
fc44bd9d.Default=G["kURbl"].clamp(G["Eykza"](fc44bd9d.Default)or fc44bd9d.Min,fc44bd9d.Min
,fc44bd9d.Max);fc44bd9d.Rounding=G["Eykza"](fc44bd9d.Rounding)or 0 end;if d99f4ab==e7fb1("#F\255\196g\150]\223"
)then local f46545=fc44bd9d.Values;local ed72ad=0;if G["iXxhM"](f46545)==e7fb1("S5\242\192h"
)then if#f46545>0 then ed72ad=#f46545 else for b9b34 in G["pvkJA"](f46545)do ed72ad=ed72ad
+1 end end end;if ed72ad>=10 then fc44bd9d.Search=true end;if fc44bd9d.Searchable~=nil then
if fc44bd9d.Search==nil then fc44bd9d.Search=fc44bd9d.Searchable end;fc44bd9d.Searchable=
nil end end;if G["iXxhM"](a146cea4[d99f4ab])~=e7fb1("EI\254\183w\144U\223")then e43de[#
e43de+1]=d99f4ab..e7fb1("\255\184H\225\232\195\142\145S5\242t\231\223p");return e57bd55064(
)end;local aab720ad=e7fb1("D@\239")..G["DkTPT"](d011da)..e7fb1(">")..d99f4ab;if d99f4ab==
e7fb1("!I\004\200r\149")then local c89a49a7,e3b688=G["GdwfY"](function()return a146cea4:
Button(fc44bd9d)end);if c89a49a7 and e3b688 then return e3b688 end;e43de[#e43de+1]=e7fb1("!I\004\200r\149 \145"
)..G["DkTPT"](e3b688);return e57bd55064()end;local function cf54a26(b1a7dd)if d99f4ab==
e7fb1("2@\249\184h\153")and b1a7dd then G["GdwfY"](function()if b1a7dd.Root then b1a7dd.
Root:SetAttribute(e7fb1("\"<\005\181q\1424\224/F\245\199v"),true)elseif b1a7dd.
SetAttribute then b1a7dd:SetAttribute(e7fb1("\"<\005\181q\1424\224/F\245\199v"),true)end
end)end;return b1a7dd end;local dd9e7e599,ee72101c4c=G["GdwfY"](function()return a146cea4[
d99f4ab](a146cea4,aab720ad,fc44bd9d)end);if dd9e7e599 and ee72101c4c then return cf54a26(
ee72101c4c)end;local f4ee9ff3c9,b312ad36=G["GdwfY"](function()return a146cea4[d99f4ab](
fc44bd9d)end);if f4ee9ff3c9 and b312ad36 then return cf54a26(b312ad36)end;e43de[#e43de+1]=
d99f4ab..e7fb1("\255\185\021\252\234\212\164Voau\248\180\015\154\022\025\244")..G["DkTPT"](
ee72101c4c)..e7fb1("\255\003\176")..G["DkTPT"](b312ad36);return e57bd55064()end;local
function dc5bbd5e(e8deda2f88,cc7768515a)local a8e56fcc,efa295e61a=G["GdwfY"](function()
return e8deda2f88:Section(cc7768515a)end);if a8e56fcc and efa295e61a then return efa295e61a
end;return e8deda2f88 end;local function b9801(edbde,e918ab3a)local b05d1,a3af73db11=G["GdwfY"
](function()return da6d76f:Tab({Title=edbde,Icon=e918ab3a})end);if b05d1 and a3af73db11
then return b797400(a3af73db11)end;local e5ac8c18=G["DkTPT"](a3af73db11);b05d1,a3af73db11=
G["GdwfY"](function()return da6d76f:Tab({Title=edbde,Icon=e7fb1("HB\246\195")})end);if
b05d1 and a3af73db11 then return b797400(a3af73db11)end;e43de[#e43de+1]=e7fb1("35\242t")..
edbde..e7fb1("\255\150Gt")..e5ac8c18;return{Container=da6d76f.ContainerHolder,ScrollFrame=
da6d76f.ContainerHolder,Type=e7fb1("35\242")}end;G["GdwfY"](d35c425e);a42ac1.Config.
PillWidth=G["kURbl"].min(196,G["kURbl"].max(120,G["kURbl"].floor(a1b2a3.X*0.34)));a42ac1.
Config.PillHeight=G["kURbl"].min(46,G["kURbl"].max(34,G["kURbl"].floor(a1b2a3.Y*0.11)));
a42ac1.Config.PillStyle=a42ac1.Config.DarkMode and e7fb1("C5\002\191")or e7fb1("K=\247\188w"
);G["GdwfY"](a42ac1.Attach,da6d76f);local d012a3=false;local function dd2a93d5a()if d012a3
then return end;d012a3=true;G["mfAgK"].delay(0.5,function()d012a3=false;local f176f00054=
da6d76f.Root;if not f176f00054 or not f176f00054.Parent then return end;local c365c16998=G["kURbl"
].floor(f176f00054.Position.X.Offset);local bbc243b=G["kURbl"].floor(f176f00054.Position.Y.
Offset);if fb214.x==c365c16998 and fb214.y==bbc243b then return end;fb214.x,fb214.y=
c365c16998,bbc243b;b48d02a()end)end;G["GdwfY"](function()da6d76f.Root:
GetPropertyChangedSignal(e7fb1("/C\003\189w\144U\223")):Connect(function()if(a42ac1.
PosGuard or 0)>0 then return end;if not da6d76f.Root.Visible then return end;addabddcd(
da6d76f,da6d76f.Root.Position.X.Offset,da6d76f.Root.Position.Y.Offset);dd2a93d5a()end)end)
;G["GdwfY"](function()local a740f0f=false;da6d76f.Root:GetPropertyChangedSignal(e7fb1(" 6\003\195o\156Z\2142=\n\185"
)):Connect(function()if(a42ac1.PosGuard or 0)>0 then return end;if a740f0f then return end
;a740f0f=true;G["mfAgK"].delay(0.6,function()a740f0f=false;local ce90dc6=da6d76f.Root;if
not ce90dc6 or not ce90dc6.Parent then return end;local b0416f1=ce90dc6.AbsoluteSize;if
b0416f1.X<260 or b0416f1.Y<220 then return end;ddb8852(b0416f1.X,b0416f1.Y);dd2a93d5a()end
)end)end);G["GdwfY"](function()dc9ee79.Set(e7fb1("\199w\021<\192\228\207\018\148\187=\018"
),0.86)end);a42ac1.Exit=function()local function fb7ea30778(d1ccd2bb)G["GdwfY"](d1ccd2bb)
end;fb7ea30778(function()if c2760544 and c2760544.Shutdown then c2760544.Shutdown()end end
);fb7ea30778(function()local c0fbdd70c=G["DLXJN"]().ChuangThreads;if G["iXxhM"](c0fbdd70c)
==e7fb1("S5\242\192h")then for af5866=#c0fbdd70c,1,-1 do G["GdwfY"](G["mfAgK"].cancel,
c0fbdd70c[af5866]);c0fbdd70c[af5866]=nil end end end);fb7ea30778(function()local a4e1ca=
c2711 and c2711:FindFirstChild(e7fb1("%@\005\185q\1553\224A=\252\185S\144R\221"));if a4e1ca
then aa3a3b2505(a4e1ca)end end);fb7ea30778(function()if fee3236e09 then fee3236e09:Destroy(
);fee3236e09=nil end end);fb7ea30778(function()local e3e0c37=da6d76f.Root;local c43fed9a=
e3e0c37 and e3e0c37.Parent;if c43fed9a then c43fed9a:Destroy()end end);fb7ea30778(function(
)if c2711 and c2711.Parent then c2711:Destroy()end end);fb7ea30778(function()local
d01be7318=G["zCZob"]:GetService(e7fb1("+=\247\188w\144T\216")):FindFirstChild(e7fb1("\"<\005\181q\142'\212QM\252\189fiR\230Q"
));if d01be7318 then d01be7318:Destroy()end end);fb7ea30778(function()local e96ba=e765953e.
Character;if e96ba then for c67c56,c92472c in G["uWcTr"](e96ba:GetDescendants())do if
c92472c.Name==e7fb1("\"<\005\181q\142:\227@=\252")or c92472c.Name==e7fb1("\"<\005\181q\142,\221X*\245\192"
)or c92472c.Name==e7fb1("\"<\005\181q\142,\221X\027\t\198r")then c92472c:Destroy()end end
end end);fb7ea30778(function()G["DLXJN"]().Chuang=nil;G["DLXJN"]().ChuangState=nil end);
fb7ea30778(function()dc9ee79.Finish()end);G["mzALM"](e7fb1(":\187:\235`G\205\006k\189-\246\232\222\152Z_Tu\219\189\022\162\253\196^/<\134\228\203\246\135\189\019\252\232\203sVms"
))end;local ab3d7={on=false,maxDist=600,fps=20,cap=35,box=true,corner=false,showName=true,
showDist=true,showHp=true,tracer=false,teamCheck=true,aliveOnly=true,skeleton=false,
skelDist=220,skelCap=8,offscreen=true,conn=nil,acc=0,gui=nil,objs={}};local d703c5d={[
e7fb1("\198mM<\140\217")]=G["KKAnN"].fromRGB(255,255,255),[e7fb1("\200q\"<\140\217")]=G["KKAnN"
].fromRGB(0,240,255),[e7fb1("\198\1422<\140\217")]=G["KKAnN"].fromRGB(255,70,70),[e7fb1("\198\136;<\140\217"
)]=G["KKAnN"].fromRGB(200,130,255),[e7fb1("\198\143O<\140\217")]=G["KKAnN"].fromRGB(80,255
,150),[e7fb1("\200\143\020<\140\217")]=G["KKAnN"].fromRGB(255,220,60)};local ae960f9=
d703c5d[e7fb1("\198mM<\140\217")];local a7260b=G["KKAnN"].fromRGB(120,235,255);local
c2048984e={{e7fb1("'9\241\184"),e7fb1("4D\000\185u{U\227RC")},{e7fb1("4D\000\185u{U\227RC"
),e7fb1("+C\007\185u{U\227RC")},{e7fb1("4D\000\185u{U\227RC"),e7fb1("+9\246\200X\151V\214Q\021\002\193"
)},{e7fb1("+9\246\200X\151V\214Q\021\002\193"),e7fb1("+9\246\200O\150]\214Q\021\002\193")}
,{e7fb1("+9\246\200O\150]\214Q\021\002\193"),e7fb1("+9\246\200K\136T\213")},{e7fb1("4D\000\185u{U\227RC"
),e7fb1("1=\247\188w|V\225DF\209\198p")},{e7fb1("1=\247\188w|V\225DF\209\198p"),e7fb1("1=\247\188wsU\232DF\209\198p"
)},{e7fb1("1=\247\188wsU\232DF\209\198p"),e7fb1("1=\247\188woG\223C")},{e7fb1("+C\007\185u{U\227RC"
),e7fb1("+9\246\200X\151V\214Q \245\187")},{e7fb1("+9\246\200X\151V\214Q \245\187"),e7fb1("+9\246\200O\150]\214Q \245\187"
)},{e7fb1("+9\246\200O\150]\214Q \245\187"),e7fb1("+9\246\200I\150U\229")},{e7fb1("+C\007\185u{U\227RC"
),e7fb1("1=\247\188w|V\225DF\220\185j")},{e7fb1("1=\247\188w|V\225DF\220\185j"),e7fb1("1=\247\188wsU\232DF\220\185j"
)},{e7fb1("1=\247\188wsU\232DF\220\185j"),e7fb1("1=\247\188wmU\224S")}};local bb5d7d6a5={{
e7fb1("'9\241\184"),e7fb1("3C\002\199r")},{e7fb1("3C\002\199r"),e7fb1("+9\246\200#hX\222")
},{e7fb1("3C\002\199r"),e7fb1("1=\247\188wG'\227L")},{e7fb1("3C\002\199r"),e7fb1("+9\246\200#sK\216"
)},{e7fb1("3C\002\199r"),e7fb1("1=\247\188wG2\214F")}};local function e46e038()if ab3d7.
gui and ab3d7.gui.Parent then return ab3d7.gui end;local de4fa9c6=G["UjcQq"].new(e7fb1("27\002\185h\149-\230H"
));de4fa9c6.Name=e7fb1("\"<\005\181q\142+\196/");de4fa9c6.ResetOnSpawn=false;de4fa9c6.
IgnoreGuiInset=true;de4fa9c6.DisplayOrder=90;de4fa9c6.ZIndexBehavior=G["oHgEP"].
ZIndexBehavior.Sibling;local ab802=G["GdwfY"](function()de4fa9c6.Parent=G["zCZob"]:
GetService(e7fb1("\"C\002\185J\156O"))end);if not ab802 or not de4fa9c6.Parent then G["GdwfY"
](function()de4fa9c6.Parent=e765953e:WaitForChild(e7fb1("/@\241\205h\153-\230H"))end)end;
ab3d7.gui=de4fa9c6;return de4fa9c6 end;local function a86d1c81e(fb4aacea1,d3b781fc)local
b0abc3729=G["UjcQq"].new(e7fb1("%F\241\193h"));b0abc3729.Name=d3b781fc;b0abc3729.
BackgroundTransparency=1;b0abc3729.BorderSizePixel=0;b0abc3729.AnchorPoint=G["JAIcf"].new(
0,0);b0abc3729.ZIndex=2;b0abc3729.Parent=fb4aacea1;return b0abc3729 end;local function
d3468(cc159,c48e73b)local e4b389=G["UjcQq"].new(e7fb1("39\008\200O\136H\214K"));e4b389.
Name=c48e73b;e4b389.BackgroundTransparency=1;e4b389.BorderSizePixel=0;e4b389.Font=G["oHgEP"
].Font.SourceSansBold;e4b389.TextColor3=G["KKAnN"].fromRGB(255,255,255);e4b389.
TextStrokeColor3=G["KKAnN"].fromRGB(0,0,0);e4b389.TextStrokeTransparency=0.2;e4b389.
TextSize=14;e4b389.TextXAlignment=G["oHgEP"].TextXAlignment.Center;e4b389.RichText=false;
e4b389.ZIndex=3;e4b389.Parent=cc159;return e4b389 end;local function ae31c55e(d2f1a10)
local da434f7=ab3d7.objs[d2f1a10];if da434f7 then return da434f7 end;local bda9d6ead=
e46e038();if not bda9d6ead then return nil end;da434f7={};da434f7.box=a86d1c81e(bda9d6ead,
e7fb1("AC\008"));da434f7.stroke=G["UjcQq"].new(e7fb1("4\029\227\200u\150Q\214"));da434f7.
stroke.ApplyStrokeMode=G["oHgEP"].ApplyStrokeMode.Border;da434f7.stroke.Thickness=2;
da434f7.stroke.Color=ae960f9;da434f7.stroke.Parent=da434f7.box;da434f7.name=d3468(
bda9d6ead,e7fb1("M5\253\185"));da434f7.name.AnchorPoint=G["JAIcf"].new(0.5,1);da434f7.dist
=d3468(bda9d6ead,e7fb1("C=\003\200"));da434f7.dist.AnchorPoint=G["JAIcf"].new(0.5,0);
da434f7.dist.TextSize=13;da434f7.hpBg=a86d1c81e(bda9d6ead,e7fb1("GD\210\187"));da434f7.
hpBg.BackgroundTransparency=0.25;da434f7.hpBg.BackgroundColor3=G["KKAnN"].fromRGB(0,0,0);
da434f7.hp=a86d1c81e(bda9d6ead,e7fb1("GD"));da434f7.hp.BackgroundTransparency=0;da434f7.c1
,da434f7.c2,da434f7.c3,da434f7.c4=a86d1c81e(bda9d6ead,e7fb1("B\005")),a86d1c81e(bda9d6ead,
e7fb1("B\006")),a86d1c81e(bda9d6ead,e7fb1("B\007")),a86d1c81e(bda9d6ead,e7fb1("B\008"));
for c6236824=1,4 do da434f7[e7fb1("B")..c6236824].BackgroundTransparency=0;da434f7[e7fb1("B"
)..c6236824].AnchorPoint=G["JAIcf"].new(0.5,0.5)end;da434f7.arrow=d3468(bda9d6ead,e7fb1("@F\002\195z"
));da434f7.arrow.Text=e7fb1("\193jB");da434f7.arrow.Font=G["oHgEP"].Font.SourceSansBold;
da434f7.arrow.TextSize=26;da434f7.arrow.Size=G["RGctw"].fromOffset(40,40);da434f7.arrow.
AnchorPoint=G["JAIcf"].new(0.5,0.5);da434f7.tracer=a86d1c81e(bda9d6ead,e7fb1("SF\241\183h\153"
));da434f7.tracer.BackgroundTransparency=0.4;da434f7.tracer.AnchorPoint=G["JAIcf"].new(0.5
,0.5);da434f7.tracer.Visible=false;ab3d7.objs[d2f1a10]=da434f7;return da434f7 end;local
function a47cff2c4(c3ee99c15,bfc8ed,b54745)if not c3ee99c15.skel then c3ee99c15.skel={}end
;local d988c26f=c3ee99c15.skel;for ad96615c7=#d988c26f+1,b54745 do local d66b16c33=G["UjcQq"
].new(e7fb1("%F\241\193h"));d66b16c33.Name=e7fb1("AC\254\185")..G["DkTPT"](ad96615c7);
d66b16c33.BorderSizePixel=0;d66b16c33.AnchorPoint=G["JAIcf"].new(0.5,0.5);d66b16c33.
BackgroundTransparency=0;d66b16c33.BackgroundColor3=a7260b;d66b16c33.ZIndex=2;d66b16c33.
Parent=bfc8ed;d988c26f[ad96615c7]=d66b16c33 end;return d988c26f end;local function
f63146af1(c94b9c62)local befa2c550=c94b9c62:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"
));if befa2c550 and befa2c550.RigType==G["oHgEP"].HumanoidRigType.R15 then return c2048984e
end;return bb5d7d6a5 end;local function a5053e1f79(c1978,c16500,f4ee9e11,de0b3691)local
eb2769,adb87002=f4ee9e11.X-c16500.X,f4ee9e11.Y-c16500.Y;local cbcc920e=G["kURbl"].sqrt(
eb2769*eb2769+adb87002*adb87002);if cbcc920e<1 then c1978.Visible=false;return end;c1978.
Visible=true;c1978.Size=G["RGctw"].fromOffset(G["kURbl"].floor(cbcc920e),de0b3691);c1978.
Position=G["RGctw"].fromOffset(G["kURbl"].floor((c16500.X+f4ee9e11.X)*0.5),G["kURbl"].
floor((c16500.Y+f4ee9e11.Y)*0.5));c1978.Rotation=G["kURbl"].deg(G["kURbl"].atan2(adb87002,
eb2769))end;ab3d7.step=function(bacef19)if not ab3d7.on then return end;ab3d7.acc=ab3d7.
acc+bacef19;local bd7933f5=1/G["kURbl"].clamp(ab3d7.fps,5,60);if ab3d7.acc<bd7933f5 then
return end;ab3d7.acc=0;local c1c15527=e09b9886cc.CurrentCamera;if not c1c15527 then return
end;local ae2329ab3=e765953e.Team;local d7db28a={};for e38f0,dacf6b in G["uWcTr"](
d31cc4e681:GetPlayers())do if dacf6b==e765953e then continue end;if ab3d7.teamCheck and
ae2329ab3~=nil and dacf6b.Team==ae2329ab3 then continue end;local e396d7b121=dacf6b.
Character;local ed60c7=e396d7b121 and e396d7b121:FindFirstChildOfClass(e7fb1("'I\253\181q\150O\213"
));local e8e0948c7d=e396d7b121 and e396d7b121:FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"
));if not ed60c7 or not e8e0948c7d then continue end;if ab3d7.aliveOnly and ed60c7.Health
<=0 then continue end;local b102853d=(e8e0948c7d.Position-c1c15527.CFrame.Position).
Magnitude;if b102853d>ab3d7.maxDist or b102853d<1 then continue end;d7db28a[#d7db28a+1]={
plr=dacf6b,hum=ed60c7,root=e8e0948c7d,ch=e396d7b121,dist=b102853d}end;G["VDLoz"].sort(
d7db28a,function(c39bc74,fa2883f7f8)return c39bc74.dist<fa2883f7f8.dist end);local d66327a
=c1c15527.ViewportSize;local b9d207=e46e038();if not b9d207 then return end;local b77ac92d
={};local c55df=G["kURbl"].min(#d7db28a,G["kURbl"].max(1,G["kURbl"].floor(ab3d7.cap)));
local c8cb0d20=G["kURbl"].max(0,G["kURbl"].floor(ab3d7.skelCap));local eb7b889e9=G["JAIcf"
].new(d66327a.X*0.5,d66327a.Y*0.5);for d312c=1,c55df do local d5d87=d7db28a[d312c];local
bcb50d7650=ae31c55e(d5d87.plr);if bcb50d7650 then b77ac92d[d5d87.plr]=true;local c4fde0ca2f
=c1c15527:WorldToViewportPoint(d5d87.root.Position+G["HchIF"].new(0,1.7,0));local b8d97cb3
=c1c15527:WorldToViewportPoint(d5d87.root.Position-G["HchIF"].new(0,1.9,0));local
c56a171787=c4fde0ca2f.Z>0 and b8d97cb3.Z>0 and c4fde0ca2f.X>-20 and c4fde0ca2f.X<d66327a.X
+20 and c4fde0ca2f.Y>-20 and c4fde0ca2f.Y<d66327a.Y+20;if not c56a171787 then bcb50d7650.
box.Visible=false;bcb50d7650.name.Visible=false;bcb50d7650.dist.Visible=false;bcb50d7650.
hpBg.Visible=false;bcb50d7650.hp.Visible=false;bcb50d7650.tracer.Visible=false;for c38ffc74
=1,4 do bcb50d7650[e7fb1("B")..c38ffc74].Visible=false end;if bcb50d7650.skel then for
f260ea7=1,#bcb50d7650.skel do bcb50d7650.skel[f260ea7].Visible=false end end;if ab3d7.
offscreen then local c5232154=c1c15527.CFrame:PointToObjectSpace(d5d87.root.Position);
local ae9229a;if c5232154.Z<0 then ae9229a=G["JAIcf"].new(c5232154.X,-c5232154.Y)else
ae9229a=G["JAIcf"].new(-c5232154.X,c5232154.Y)end;if ae9229a.Magnitude<0.001 then ae9229a=
G["JAIcf"].new(0,-1)end;ae9229a=ae9229a.Unit;local d686a2063=40;local c4ca38b,c86070ce9=G["kURbl"
].huge,G["kURbl"].huge;if ae9229a.X>0.0001 then c4ca38b=(d66327a.X-d686a2063-eb7b889e9.X)/
ae9229a.X elseif ae9229a.X<-0.0001 then c4ca38b=(d686a2063-eb7b889e9.X)/ae9229a.X end;if
ae9229a.Y>0.0001 then c86070ce9=(d66327a.Y-d686a2063-eb7b889e9.Y)/ae9229a.Y elseif ae9229a.
Y<-0.0001 then c86070ce9=(d686a2063-eb7b889e9.Y)/ae9229a.Y end;local ee3045=G["kURbl"].min(
c4ca38b,c86070ce9);if ee3045==G["kURbl"].huge or ee3045<=0 then ee3045=60 end;local b8f16=
G["JAIcf"].new(eb7b889e9.X+ae9229a.X*ee3045,eb7b889e9.Y+ae9229a.Y*ee3045);bcb50d7650.arrow.
Visible=true;bcb50d7650.arrow.Position=G["RGctw"].fromOffset(G["kURbl"].floor(b8f16.X),G["kURbl"
].floor(b8f16.Y));bcb50d7650.arrow.Rotation=G["kURbl"].deg(G["kURbl"].atan2(ae9229a.X,-
ae9229a.Y))else bcb50d7650.arrow.Visible=false end;continue end;bcb50d7650.arrow.Visible=
false;local b9b2df544b,a68ebb0=c4fde0ca2f.Y,b8d97cb3.Y;if a68ebb0<b9b2df544b then
b9b2df544b,a68ebb0=a68ebb0,b9b2df544b end;local e7020a069=G["kURbl"].clamp(a68ebb0-
b9b2df544b,12,d66327a.Y*0.62);local a2f570dba=G["kURbl"].max(10,e7020a069*0.55);local
b06cbf3c4b=(c4fde0ca2f.X+b8d97cb3.X)*0.5;local e128c=b06cbf3c4b-a2f570dba*0.5;local
fbdcbb4bb0=G["kURbl"].clamp(G["kURbl"].floor(e7020a069*0.045),2,4);local aab41dcb1=G["kURbl"
].clamp(G["kURbl"].floor(d66327a.Y*0.024),13,22);bcb50d7650.box.Visible=ab3d7.box;if ab3d7.
box then bcb50d7650.box.Position=G["RGctw"].fromOffset(G["kURbl"].floor(e128c),G["kURbl"].
floor(b9b2df544b));bcb50d7650.box.Size=G["RGctw"].fromOffset(G["kURbl"].floor(a2f570dba),G["kURbl"
].floor(e7020a069));bcb50d7650.stroke.Thickness=fbdcbb4bb0;bcb50d7650.stroke.Color=ae960f9
end;for da6bc378a=1,4 do local d77b7e923c=bcb50d7650[e7fb1("B")..da6bc378a];if ab3d7.
corner then local a9caa=G["kURbl"].clamp(e7020a069*0.22,6,16);local cd127a967b=(da6bc378a
==1 or da6bc378a==3)and e128c or(e128c+a2f570dba);local cf92de5e=(da6bc378a<=2)and
b9b2df544b or(b9b2df544b+e7020a069);local fd3b398db3=(da6bc378a==1 or da6bc378a==3)and 1 or
-1;local e90a81=(da6bc378a<=2)and 1 or-1;d77b7e923c.Visible=true;d77b7e923c.
BackgroundColor3=ae960f9;d77b7e923c.Size=G["RGctw"].fromOffset(G["kURbl"].floor(a9caa*1.4)
,fbdcbb4bb0+1);d77b7e923c.Position=G["RGctw"].fromOffset(G["kURbl"].floor(cd127a967b+
fd3b398db3*a9caa*0.45),G["kURbl"].floor(cf92de5e+e90a81*a9caa*0.45));d77b7e923c.Rotation=
e90a81*fd3b398db3>0 and 45 or-45 else d77b7e923c.Visible=false end end;local e6e9216bf=G["kURbl"
].clamp(d5d87.hum.Health/G["kURbl"].max(d5d87.hum.MaxHealth,1),0,1);local b7dc69dcfe=G["kURbl"
].clamp(G["kURbl"].floor(e7020a069*0.09),4,7);local b60bc2d6cb=b9b2df544b+e7020a069+3;
bcb50d7650.hpBg.Visible=ab3d7.showHp;bcb50d7650.hp.Visible=ab3d7.showHp;if ab3d7.showHp
then bcb50d7650.hpBg.Position=G["RGctw"].fromOffset(G["kURbl"].floor(e128c),G["kURbl"].
floor(b60bc2d6cb));bcb50d7650.hpBg.Size=G["RGctw"].fromOffset(G["kURbl"].floor(a2f570dba),
b7dc69dcfe);if e6e9216bf>0.55 then bcb50d7650.hp.BackgroundColor3=G["KKAnN"].fromRGB(70,
255,110)elseif e6e9216bf>0.25 then bcb50d7650.hp.BackgroundColor3=G["KKAnN"].fromRGB(255,
205,40)else bcb50d7650.hp.BackgroundColor3=G["KKAnN"].fromRGB(255,50,50)end;bcb50d7650.hp.
Position=G["RGctw"].fromOffset(G["kURbl"].floor(e128c),G["kURbl"].floor(b60bc2d6cb));
bcb50d7650.hp.Size=G["RGctw"].fromOffset(G["kURbl"].max(1,G["kURbl"].floor(a2f570dba*
e6e9216bf)),b7dc69dcfe)end;bcb50d7650.tracer.Visible=ab3d7.tracer;if ab3d7.tracer then
bcb50d7650.tracer.BackgroundColor3=ae960f9;a5053e1f79(bcb50d7650.tracer,G["JAIcf"].new(
d66327a.X*0.5,d66327a.Y-6),G["JAIcf"].new(b06cbf3c4b,b9b2df544b+e7020a069*0.5),2)end;local
bec0c=d5d87.plr.DisplayName;if bec0c==nil or bec0c==e7fb1("")then bec0c=d5d87.plr.Name end
;bcb50d7650.name.Visible=ab3d7.showName;if ab3d7.showName then bcb50d7650.name.Text=bec0c..
e7fb1("\255\244")..G["DkTPT"](G["kURbl"].floor(d5d87.hum.Health));bcb50d7650.name.TextSize
=aab41dcb1;bcb50d7650.name.Size=G["RGctw"].fromOffset(G["kURbl"].floor(a2f570dba)+60,
aab41dcb1+8);bcb50d7650.name.Position=G["RGctw"].fromOffset(G["kURbl"].floor(b06cbf3c4b),G["kURbl"
].floor(b9b2df544b-2));bcb50d7650.name.TextColor3=G["KKAnN"].fromRGB(255,255,255);
bcb50d7650.name.TextStrokeTransparency=0.15 end;bcb50d7650.dist.Visible=ab3d7.showDist;if
ab3d7.showDist then bcb50d7650.dist.Text=G["DkTPT"](G["kURbl"].floor(d5d87.dist))..e7fb1("L"
);bcb50d7650.dist.TextSize=G["kURbl"].clamp(G["kURbl"].floor(aab41dcb1*0.85),12,18);
bcb50d7650.dist.Size=G["RGctw"].fromOffset(70,(aab41dcb1)+4);bcb50d7650.dist.Position=G["RGctw"
].fromOffset(G["kURbl"].floor(b06cbf3c4b),G["kURbl"].floor(b9b2df544b+e7020a069+b7dc69dcfe
+6))end;if ab3d7.skeleton and c8cb0d20>0 and d5d87.dist<=ab3d7.skelDist then c8cb0d20=
c8cb0d20-1;local bfa78c4068=f63146af1(d5d87.ch);local bf22e19774=a47cff2c4(bcb50d7650,
b9d207,#bfa78c4068);for b0de5285=1,#bfa78c4068 do local ca709c=bf22e19774[b0de5285];local
df40ee928=d5d87.ch:FindFirstChild(bfa78c4068[b0de5285][1]);local f2a14349ca=d5d87.ch:
FindFirstChild(bfa78c4068[b0de5285][2]);if ca709c and df40ee928 and f2a14349ca and
df40ee928:IsA(e7fb1("!5\003\185S\136X\229"))and f2a14349ca:IsA(e7fb1("!5\003\185S\136X\229"
))then local e819c8a21=c1c15527:WorldToViewportPoint(df40ee928.Position);local f52e23=
c1c15527:WorldToViewportPoint(f2a14349ca.Position);if e819c8a21.Z>0 and f52e23.Z>0 then
ca709c.BackgroundColor3=a7260b;a5053e1f79(ca709c,G["JAIcf"].new(e819c8a21.X,e819c8a21.Y),G["JAIcf"
].new(f52e23.X,f52e23.Y),fbdcbb4bb0)else ca709c.Visible=false end elseif ca709c then ca709c.
Visible=false end end;for bfc1cdf1=#bfa78c4068+1,#bf22e19774 do if bf22e19774[bfc1cdf1]
then bf22e19774[bfc1cdf1].Visible=false end end elseif bcb50d7650.skel then for f2e96a706b
=1,#bcb50d7650.skel do if bcb50d7650.skel[f2e96a706b]then bcb50d7650.skel[f2e96a706b].
Visible=false end end end end end;for beac4fd,ead47fce72 in G["pvkJA"](ab3d7.objs)do if not
b77ac92d[beac4fd]then ead47fce72.box.Visible=false;ead47fce72.name.Visible=false;
ead47fce72.dist.Visible=false;ead47fce72.hpBg.Visible=false;ead47fce72.hp.Visible=false;
ead47fce72.tracer.Visible=false;ead47fce72.arrow.Visible=false;for a4ad720f=1,4 do
ead47fce72[e7fb1("B")..a4ad720f].Visible=false end;if ead47fce72.skel then for e80893=1,#
ead47fce72.skel do if ead47fce72.skel[e80893]then ead47fce72.skel[e80893].Visible=false end
end end end end;local a24c8cbfbb=nil;for f047b in G["pvkJA"](ab3d7.objs)do if f047b.Parent
==nil then a24c8cbfbb=a24c8cbfbb or{};a24c8cbfbb[#a24c8cbfbb+1]=f047b end end;if a24c8cbfbb
then for a903cd=1,#a24c8cbfbb do local dd6d444da=ab3d7.objs[a24c8cbfbb[a903cd]];if
dd6d444da then for e95f0,f1adf2b3d3 in G["uWcTr"]({e7fb1("AC\008"),e7fb1("M5\253\185"),
e7fb1("C=\003\200"),e7fb1("GD\210\187"),e7fb1("GD"),e7fb1("B\005"),e7fb1("B\006"),e7fb1("B\007"
),e7fb1("B\008"),e7fb1("@F\002\195z"),e7fb1("SF\241\183h\153")})do if dd6d444da[f1adf2b3d3
]then G["GdwfY"](function()dd6d444da[f1adf2b3d3]:Destroy()end)end end;if dd6d444da.skel
then for f13056441=1,#dd6d444da.skel do G["GdwfY"](function()dd6d444da.skel[f13056441]:
Destroy()end)end end end;ab3d7.objs[a24c8cbfbb[a903cd]]=nil end end end;ab3d7.set=function(
c92cde5bf)ab3d7.on=c92cde5bf and true or false;if not ab3d7.on then if ab3d7.conn then G["GdwfY"
](function()ab3d7.conn:Disconnect()end);ab3d7.conn=nil end;for d8cb7,c08cdb817 in G["pvkJA"
](ab3d7.objs)do for a137fdcc7b,a8ce8 in G["uWcTr"]({e7fb1("AC\008"),e7fb1("M5\253\185"),
e7fb1("C=\003\200"),e7fb1("GD\210\187"),e7fb1("GD"),e7fb1("B\005"),e7fb1("B\006"),e7fb1("B\007"
),e7fb1("B\008"),e7fb1("@F\002\195z"),e7fb1("SF\241\183h\153")})do if c08cdb817[a8ce8]then
G["GdwfY"](function()c08cdb817[a8ce8]:Destroy()end)end end;if c08cdb817.skel then for
fe174657=1,#c08cdb817.skel do G["GdwfY"](function()c08cdb817.skel[fe174657]:Destroy()end)
end end end;G["VDLoz"].clear(ab3d7.objs);if ab3d7.gui then G["GdwfY"](function()ab3d7.gui:
Destroy()end);ab3d7.gui=nil end;return end;e46e038();if not ab3d7.conn then ab3d7.conn=
e26cc.RenderStepped:Connect(function(b43ff460)ab3d7.step(b43ff460)end)end;c2760544.Notify(
e7fb1("\198\143(9\139\221"),e7fb1("$'\224t\232\222\152V\155Tu\228\178G\168(\255\186,\212\235\230\130\145"
)..G["DkTPT"](G["kURbl"].floor(ab3d7.maxDist))..e7fb1("\255\1860\016"),4)end;local f8ce9f08
=b9801(e7fb1("\198\143(9\139\221"),e7fb1("DM\245"));c6c7685e3.Tabs.Esp=f8ce9f08;dc5bbd5e(
f8ce9f08,e7fb1("\197TK9\191\167\203\246\146"));c1d209d5(f8ce9f08,e7fb1("3C\247\187o\140"),{
Title=e7fb1("\196\130.:\154\221\006\1822$"),Description=e7fb1("\196\130.8\193\178\204)\145\186/\231#\233\157\145\197j\0239\176\190\203\003k\1861\218\234\225\165Xs\133u\016\152\ry\255\198hKC\191\179\202)_\185>\238\234\195qV\157kv\012\136"
),Callback=function(a5c1d1)ab3d7.set(a5c1d1)end});c1d209d5(f8ce9f08,e7fb1("/5\002\181j\153G\225G"
),{Title=e7fb1("\199\131D:\155\181"),Content=e7fb1("\200\143(<\177\203\205\005\154\244\195\137#\011\160+\194T\018:\145\176\203)\134\185@\005\233\179oZ\128\142u\014\146\012k$\206\144*:\146\182\205+\158\244r\218\149G\206\024q\1861\218#\tl\003\255\189:\252\233\197\156`\155`u\218\144\rp\251\195\142J:\152\215\207\nl\185\024\004#X\027T_V"
)});dc5bbd5e(f8ce9f08,e7fb1("\197lN;\167\225\207\018\152"));c1d209d5(f8ce9f08,e7fb1("3C\247\187o\140"
),{Title=e7fb1("\197jI:\164\173"),Default=true,Callback=function(e9963f)ab3d7.box=e9963f
and true or false end});c1d209d5(f8ce9f08,e7fb1("3C\247\187o\140"),{Title=e7fb1("\199{\":\164\173"
),Description=e7fb1("\200\143(<\177\203\203\246\146\195L\224\232\227fU\153Zv\239\183\015p\"\195\145\0229\167\193\203\001b\186\016\251\235\170\163"
),Default=false,Callback=function(dc792)ab3d7.corner=dc792 and true or false end});
c1d209d5(f8ce9f08,e7fb1("3C\247\187o\140"),{Title=e7fb1("\196d\0299\176\190\203\003k\1881\212\236\174u"
),Default=true,Callback=function(b7a2f3)ab3d7.showName=b7a2f3 and true or false end});
c1d209d5(f8ce9f08,e7fb1("3C\247\187o\140"),{Title=e7fb1("\199\139-;\169\226"),Default=true
,Callback=function(c2f9f4055)ab3d7.showDist=c2f9f4055 and true or false end});c1d209d5(
f8ce9f08,e7fb1("3C\247\187o\140"),{Title=e7fb1("\199u\016:\160\200"),Default=true,Callback
=function(a618052ed7)ab3d7.showHp=a618052ed7 and true or false end});c1d209d5(f8ce9f08,
e7fb1("3C\247\187o\140"),{Title=e7fb1("\197c\031;\189\230"),Description=e7fb1("\195\143\0309\180\182\203*t\185J\233\236\170\142Y\158ru\220\179\014\129\031\197t\023C\191\179\202+\153\1854\238\231\227\128Ww\146u\018\154\011\159\"\206\144\028=\190\191\206\031\131\185\021\007"
),Default=false,Callback=function(a2a125b7)ab3d7.tracer=a2a125b7 and true or false end});
dc5bbd5e(f8ce9f08,e7fb1("\200~8:\161\221\202)m\185A\227\232\203|"));c1d209d5(f8ce9f08,
e7fb1("3C\247\187o\140"),{Title=e7fb1("\200~8:\161\221\213-g\189:\252\236\209\162Y\158rw\014\194\022\162\250"
),Description=e7fb1("\196c:;\151\226\2060p\1854\216\234\193jU\153\142\127\016\143y\028\145\014\244\226\1338G\207\244\156\186$\003\233\179g"
),Default=false,Callback=function(ca9fb4)ab3d7.skeleton=ca9fb4 and true or false end});
c1d209d5(f8ce9f08,e7fb1("3C\247\187o\140"),{Title=e7fb1("\196\133\0319\167\189\205\031\140\1854\008"
),Description=e7fb1("\195\142J8\187\180\203\r\135\187$\015\236\196\136Zf`u\004\180\012\130\025\199\146I;\191\191\204\253f\184H\254\234\213\147V\131\136"
),Default=true,Callback=function(c51ca9e4)ab3d7.offscreen=c51ca9e4 and true or false end})
;c1d209d5(f8ce9f08,e7fb1("2@\249\184h\153"),{Title=e7fb1("\200~8:\161\221\204\r_\188O\240\235\222\131X\133\143"
),Description=e7fb1("\199\138\021<\194\174\2060x\184H\254\235\222\131X\133\143t\012\144\014z,\200~8=\173\227"
),Min=50,Max=800,Default=220,Callback=function(d4ede3)ab3d7.skelDist=G["kURbl"].floor(
d4ede3)end});c1d209d5(f8ce9f08,e7fb1("2@\249\184h\153"),{Title=e7fb1("\200~8:\161\221\204\r_\1854\238\234\187\161Vftt\014\189"
),Description=e7fb1("\200~8=\173\227\204\r_\185 \215\233\167\141Yb\145\127\016\143\016\161\t\199\1304t;"
),Min=1,Max=20,Default=8,Callback=function(bffb3a)ab3d7.skelCap=G["kURbl"].floor(bffb3a)
end});dc5bbd5e(f8ce9f08,e7fb1("\199\147\023:\190\203\202)m\186\016\251\235\170\163"));
c1d209d5(f8ce9f08,e7fb1("3C\247\187o\140"),{Title=e7fb1("\200l/8\191\180\2060f\186K\248"),
Description=e7fb1("\196\144\016;\160\167\203!\144\184H\225\234\187\161Vo`y\236\162\014\128\245\195\142J"
),Default=true,Callback=function(fdc8cd8d)ab3d7.teamCheck=fdc8cd8d and true or false end})
;c1d209d5(f8ce9f08,e7fb1("3C\247\187o\140"),{Title=e7fb1("\196c:;\151\226\204%\154\184J\014"
),Default=true,Callback=function(f252e0)ab3d7.aliveOnly=f252e0 and true or false end});
c1d209d5(f8ce9f08,e7fb1("2@\249\184h\153"),{Title=e7fb1("\197p\016<\194\195\206(|\1876\015"
),Description=e7fb1("\197tLC\191\175Y\229T8\003C\191\176"),Min=50,Max=3000,Default=600,
Callback=function(a03d8f56a)ab3d7.maxDist=G["kURbl"].floor(a03d8f56a)end});c1d209d5(
f8ce9f08,e7fb1("2@\249\184h\153"),{Title=e7fb1("\196\\G:\153\215\207\019p\187\030\219"),
Description=e7fb1("\197\131\031;\170\185\205\005\154\185\023\244\233\211\135`\155`x\n\141\011\163\255\199\138\026;\159\168"
),Min=5,Max=60,Default=20,Callback=function(f6a9f18796)ab3d7.fps=G["kURbl"].floor(
f6a9f18796)end});c1d209d5(f8ce9f08,e7fb1("2@\249\184h\153"),{Title=e7fb1("\197p\0169\167\193\205\005\154\185\023\244\231\223\144U\153\142"
),Description=e7fb1("\197`\025<\186\196\205\023\154\188O\229\234\193jU\155lu\217\139G\168(\255\189K\236\235\213\138\145\018\t"
),Min=1,Max=60,Default=35,Callback=function(b9808)ab3d7.cap=G["kURbl"].floor(b9808)end});
dc5bbd5e(f8ce9f08,e7fb1("\196x&<\170\169"));c1d209d5(f8ce9f08,e7fb1("#F\255\196g\150]\223"
),{Title=e7fb1("\200Y\029<\140\217"),Description=e7fb1("\197hI9\177\179\205\028j\185\024\015\234\187\133Wt\\\127\016\143\014\127.\197p\0168\189\213"
),Values={e7fb1("\198mM<\140\217"),e7fb1("\200q\"<\140\217"),e7fb1("\198\1422<\140\217"),
e7fb1("\198\136;<\140\217"),e7fb1("\198\143O<\140\217"),e7fb1("\200\143\020<\140\217")},
Default=e7fb1("\198mM<\140\217"),Callback=function(bf78142c)ae960f9=d703c5d[bf78142c]or
d703c5d[e7fb1("\198mM<\140\217")]end});local f9ed2=b9801(e7fb1("\200T*;\151\207"),e7fb1("R@\249\184h\153Y"
));c6c7685e3.Tabs.General=f9ed2;dc5bbd5e(f9ed2,e7fb1("\198{K9\141\207"));local c33c6e=
e88fc7d0.baseSpeed or 16;c6c7685e3.Controls.SpeedSlider=c1d209d5(f9ed2,e7fb1("2@\249\184h\153"
),{Title=e7fb1("\198{K9\141\207\207\241~\185J\250"),Description=e7fb1("\200\143(<\177\203\206(~\186H\012\233\175uU\151Tx\219\183\022\162\249\196\145#9\140\180\006"
)..G["DkTPT"](G["kURbl"].floor(c33c6e))..e7fb1("\206\144\025"),Min=0,Max=350,Default=G["kURbl"
].clamp(G["kURbl"].floor(c33c6e),0,350),Callback=function(d34d3)c2760544.Config.WalkSpeed=
d34d3;if c2760544.Config.SpeedOn then c2760544.SetSpeed(d34d3)end end});c6c7685e3.Controls.
SpeedToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\200T/9\189\205"),
Description=e7fb1("\196YC=\154\212\203\001m\185+\242\232\175\150W\151\140v\220\146\012t\016\197p<;\157\171\207\241~\185J\250"
),Callback=function(d28acf6fb)c2760544.Config.SpeedOn=d28acf6fb and true or false;e88fc7d0.
speedOn=d28acf6fb and true or false;if not d28acf6fb then c2760544.SetSpeed(e88fc7d0.
baseSpeed or 16);G["GdwfY"](function()c6c7685e3.Controls.SpeedSlider:SetValue(G["kURbl"].
clamp(G["kURbl"].floor(e88fc7d0.baseSpeed or 16),0,350))end)else c2760544.SetSpeed(
c2760544.Config.WalkSpeed or e88fc7d0.baseSpeed or 16);G["GdwfY"](e6f80e548)end end});
local fec4e3;if e88fc7d0.baseUseJumpPower then fec4e3=e88fc7d0.baseJumpPower or 50 else
fec4e3=e88fc7d0.baseJumpHeight or 7.2 end;c6c7685e3.Controls.JumpSlider=c1d209d5(f9ed2,
e7fb1("2@\249\184h\153"),{Title=e7fb1("\199\139C<\186\170\207\028w\185J\250"),Description=
e7fb1("\200\143(<\177\203\206(~\186H\012\233\175uU\151Tx\219\183\022\162\249\196\145#9\140\180\006"
)..G["DkTPT"](G["kURbl"].floor(fec4e3*10)/10)..e7fb1("\206\144\025"),Min=0,Max=500,Default
=G["kURbl"].clamp(fec4e3,0,500),Callback=function(cea83fd92)c2760544.Config.JumpPower=
cea83fd92;e88fc7d0.jumpValue=cea83fd92;if c2760544.Config.JumpOn then c2760544.
SetJumpHeight(cea83fd92)end end});c6c7685e3.Controls.GravityInput=c1d209d5(f9ed2,e7fb1("(B\000\201w"
),{Title=e7fb1("\200[\0299\141\194"),Description=e7fb1("\200\143(<\177\203\006\162\024\n\190\134"
),Default=e7fb1("\016\r\198\1305"),Placeholder=e7fb1("\016\r\198\1305"),Callback=function(
c4f61)local b30ed8738c=G["Eykza"](c4f61);if b30ed8738c then c2760544.Config.Gravity=
b30ed8738c;if c2760544.Config.GravityOn then c2760544.SetGravity(b30ed8738c)end end end});
c6c7685e3.Controls.FovSlider=c1d209d5(f9ed2,e7fb1("2@\249\184h\153"),{Title=e7fb1("\196\141O<\170\185"
),Description=e7fb1("\200\143(<\177\203\006\168\015"),Min=30,Max=120,Default=70,Callback=
function(a56c35499)c2760544.SetFOV(a56c35499)end});dc5bbd5e(f9ed2,e7fb1("\198]I:\177\177\205\024\154\185\026\252"
));c6c7685e3.Controls.NoclipToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\198}O9\165\192"
),Description=e7fb1("\196YC=\154\212\205\019\143\186\"\242"),Callback=function(d2b3a3a)
c2760544.Noclip(d2b3a3a)end});c6c7685e3.Controls.InfJumpToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"
),{Title=e7fb1("\197k0=\156\183\206(\146\188G\215"),Description=e7fb1("\197`\0258\192\182\205\026\153\1860\016\231\223sWu\129x\011\182"
),Callback=function(c78b49)c2760544.InfiniteJump(c78b49)end});c6c7685e3.Controls.
FreezeToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\197k0:\182\188\205\024\154\185\026\252"
),Description=e7fb1("\200h\017:\176\226\206\248\137\185G\005"),Callback=function(dc899cae)
c2760544.Freeze(dc899cae)end});c6c7685e3.Controls.FlyToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"
),{Title=e7fb1("\200w.<\164\179"),Description=e7fb1("\198h8:\148\174\204\014e\186&\r\232\183wZ\130r"
),Callback=function(c29bcd36)c2760544.Fly(c29bcd36)end});c6c7685e3.Controls.FlySpeedSlider
=c1d209d5(f9ed2,e7fb1("2@\249\184h\153"),{Title=e7fb1("\200w.<\164\179\207\241~\185J\250")
,Min=10,Max=400,Default=100,Callback=function(fc15bcb0b)c2760544.SetFlySpeed(fc15bcb0b)end
});c6c7685e3.Controls.SpinToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\199[:<\192\211"
),Description=e7fb1("\196b/9\159\215\204\008j\188M\000"),Callback=function(f1aaa53)
c2760544.SetSpin(f1aaa53,c2760544.Config.SpinSpeed)end});c6c7685e3.Controls.
SpinSpeedSlider=c1d209d5(f9ed2,e7fb1("2@\249\184h\153"),{Title=e7fb1("\199[:<\192\211\207\241~\185J\250"
),Min=1,Max=90,Default=10,Callback=function(ccadd53cd)c2760544.Config.SpinSpeed=ccadd53cd
end});c6c7685e3.Controls.RevVoidToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"),{Title=
e7fb1("\196c\029<\156\193\205\026\153"),Description=e7fb1("\197b\0258\187\178\203\255\154\188\023\254\232\177\142Wj]u\239\161"
),Callback=function(c9a4da)c2760544.AntiVoid(c9a4da)end});local e7389=b9801(e7fb1("\199{\"<\140\217"
),e7fb1("TG\245\198"));c6c7685e3.Tabs.Char=e7389;dc5bbd5e(e7389,e7fb1("\199u\016=\138\182"
));c6c7685e3.Controls.MaxHealthSlider=c1d209d5(e7389,e7fb1("2@\249\184h\153"),{Title=e7fb1("\199u\016=\138\182\202)i\189)\228"
),Min=100,Max=10000,Default=100,Callback=function(f5ffccf)c2760544.SetMaxHealth(f5ffccf)
end});c6c7685e3.Controls.HealthSlider=c1d209d5(e7389,e7fb1("2@\249\184h\153"),{Title=e7fb1("\196\145#9\140\180\206\018_\189\023\227"
),Min=1,Max=10000,Default=100,Callback=function(e147b)c2760544.SetHealth(e147b)end});
c6c7685e3.Controls.GodToggle=c1d209d5(e7389,e7fb1("3C\247\187o\140"),{Title=e7fb1("\197k0:\152\179"
),Description=e7fb1("\196\1302:\139\222\205\028\142\189$\213\235\200f"),Callback=function(
f6de0a5cf3)c2760544.GodMode(f6de0a5cf3)end});dc5bbd5e(e7389,e7fb1("\196x&<\170\169"));
c6c7685e3.Controls.InvisibleToggle=c1d209d5(e7389,e7fb1("3C\247\187o\140"),{Title=e7fb1("\200n <\189\210"
),Description=e7fb1("\196Y8<\189\210\207\241n\186(\226"),Callback=function(f81d7cfd98)
c2760544.Invisible(f81d7cfd98)end});c6c7685e3.Controls.HeadlessToggle=c1d209d5(e7389,e7fb1("3C\247\187o\140"
),{Title=e7fb1("\197k09\167\219"),Description=e7fb1("\196xD=\134\207\207\011o\188'\227"),
Callback=function(afb700)c2760544.Headless(afb700)end});c6c7685e3.Controls.KorbloxToggle=
c1d209d5(e7389,e7fb1("3C\247\187o\140"),{Title=e7fb1("\197j=<\136\230"),Description=e7fb1("*C\002\182o\150^\145\196cC<\136\230"
),Callback=function(d46585e7)c2760544.Korblox(d46585e7)end});c6c7685e3.Controls.
NightToggle=c1d209d5(e7389,e7fb1("3C\247\187o\140"),{Title=e7fb1("\196x,<\170\173"),
Description=e7fb1("\197c 8\189\213\205\005\154\189-\246"),Callback=function(ed63af7a44)
c2760544.NightVision(ed63af7a44)end});c6c7685e3.Controls.AnimDropdown=c1d209d5(e7389,e7fb1("#F\255\196g\150]\223"
),{Title=e7fb1("\196^8;\151\226\203\253d"),Description=e7fb1("\200T\0258\187\167\202)\137\186+\019\233\180\136Z\154lx\002\167\012p\025\195\145,"
),Values=c2760544.ListAnimations(),Default=e7fb1("\196\147\029<\131\172"),Callback=
function(f694f67eea)c2760544.ApplyAnimation(f694f67eea)end});local ac1c2=b9801(e7fb1("\198h9=\166\197"
),e7fb1("RK\255\198g\154"));c6c7685e3.Tabs.Fling=ac1c2;dc5bbd5e(ac1c2,e7fb1("\198o>:\163\174"
));local f6bb9f85=f9e5b2a1ee();c6c7685e3.Controls.TargetDropdown=c1d209d5(ac1c2,e7fb1("#F\255\196g\150]\223"
),{Title=e7fb1("\198o>:\163\174\205\255\136\185>\n"),Description=e7fb1("\196\\G:\153\215\203\001m\185\022\225\236\167o"
),Values=f6bb9f85,Default=f6bb9f85[1],Callback=function(e83411503)e03cdb.name=e83411503;
e03cdb.player=d31cc4e681:FindFirstChild(e83411503)end});c1d209d5(ac1c2,e7fb1("!I\004\200r\149"
),{Title=e7fb1("\196\\G:\153\215\205\255\136\185>\n\232\175}Y\128|"),Description=e7fb1("\198b99\177\221\2060z\185\023\014\232\183tXa\141t\012\131\011\158\252"
),Callback=function()c61fe45d3d()end});dc5bbd5e(ac1c2,e7fb1("\195\1440=\131\168"));
c1d209d5(ac1c2,e7fb1("!I\004\200r\149"),{Title=e7fb1("\195\1440=\131\168\203\249\143\187+\002\233\199m"
),Callback=function()local c9a8a79977=a49516();if c9a8a79977 then c2760544.TeleportTo(
c9a8a79977.Name,c2760544.Config.TeleOffset,c2760544.Config.SideOffset or 0,c2760544.Config.
UpOffset or 3)end end});c1d209d5(ac1c2,e7fb1("!I\004\200r\149"),{Title=e7fb1("\197^\026;\158\213\204\017f\186\027\221\235\230mW|y"
),Callback=function()local d95293=a49516();if d95293 then c2760544.BringTo(d95293.Name,3)
end end});c6c7685e3.Controls.TeleOffsetSlider=c1d209d5(ac1c2,e7fb1("2@\249\184h\153"),{
Title=e7fb1("\195\1440=\131\168\203\250l\185 \226\232\168uX\134\143"),Description=e7fb1("\197\1293:\152\215\203\r\135\185\025\225\242\227rY\147sv\233\179\012\130\025\196d\030"
),Min=-50,Max=50,Default=3,Callback=function(a6eb7a7d)c2760544.Config.TeleOffset=a6eb7a7d
end});c6c7685e3.Controls.TeleSideSlider=c1d209d5(ac1c2,e7fb1("2@\249\184h\153"),{Title=
e7fb1("\195\1440=\131\168\203(\133\185\031\007\232\168uX\134\143"),Description=e7fb1("\197\1293:\152\215\203\r\135\185\031\007\242\227rY\147sv\233\179\012\130\025\196\1396"
),Min=-50,Max=50,Default=0,Callback=function(a32833ffb)c2760544.Config.SideOffset=
a32833ffb end});c6c7685e3.Controls.TeleUpSlider=c1d209d5(ac1c2,e7fb1("2@\249\184h\153"),{
Title=e7fb1("\195\1440=\131\168\202)i\184H\223\232\168uX\134\143"),Description=e7fb1("\200\143(<\177\203\006\164"
),Min=-20,Max=60,Default=3,Callback=function(d1a7f8b0)c2760544.Config.UpOffset=d1a7f8b0 end
});dc5bbd5e(ac1c2,e7fb1("\198h9=\166\197"));c1d209d5(ac1c2,e7fb1("!I\004\200r\149"),{Title
=e7fb1("\198h9=\166\197\202)_\186<\245"),Description=e7fb1("\196\131I9\192\186\203\250l\187+\002\233\199m"
),Callback=function()local b3bf1a21=a49516();if b3bf1a21 then c2760544.Fling(b3bf1a21.Name
)end end});c1d209d5(ac1c2,e7fb1("!I\004\200r\149"),{Title=e7fb1("\198h9=\166\197\204\250_\186,\221\231\225\160"
),Description=e7fb1("\200m4<\138\209\203(\144\184K\249\232\203|Vd|y\215\171"),Callback=
function()c2760544.FlingAll()end});c6c7685e3.Controls.TouchFlingToggle=c1d209d5(ac1c2,
e7fb1("3C\247\187o\140"),{Title=e7fb1("\198v@9\139\215\203!\144\187$\253\236\202\132"),
Description=e7fb1("\199[:9\186\216\203)\133\187-\212\236\167\133V\153zv\230\161\011\160+")
,Callback=function(a34d594edb)c2760544.TouchFling(a34d594edb)end});dc5bbd5e(ac1c2,e7fb1("\198b?;\190\188"
));c6c7685e3.Controls.OrbitToggle=c1d209d5(ac1c2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\198b?;\190\188\205\012\141\1860\219"
),Description=e7fb1("\198\143%9\159\175\206%\147\187-\212\234\194\148W\127[x\011\148"),
Callback=function(f1511)if f1511 then local c6b0b057ab=a49516();if not c6b0b057ab then
return false end;return c2760544.Orbit(c6b0b057ab.Name,true,c2760544.Config.OrbitRadius,
c2760544.Config.OrbitHeight,c2760544.Config.OrbitSpeed)end;c2760544.Orbit(nil,false)end});
c6c7685e3.Controls.OrbitRadiusSlider=c1d209d5(ac1c2,e7fb1("2@\249\184h\153"),{Title=e7fb1("\198b?;\190\188\203\254i\185N\216"
),Min=2,Max=60,Default=10,Callback=function(ad1851)c2760544.Config.OrbitRadius=ad1851 end}
);c6c7685e3.Controls.OrbitHeightSlider=c1d209d5(ac1c2,e7fb1("2@\249\184h\153"),{Title=
e7fb1("\198b?;\190\188\207\028w\185J\250"),Min=-20,Max=25,Default=0,Callback=function(
d3e35)c2760544.Config.OrbitHeight=d3e35 end});c6c7685e3.Controls.OrbitSpeedSlider=c1d209d5(
ac1c2,e7fb1("2@\249\184h\153"),{Title=e7fb1("\198b?;\190\188\207\241~\185J\250"),Min=1,Max
=120,Default=6,Callback=function(e1ddb8633)c2760544.Config.OrbitSpeed=e1ddb8633/10 end});
local c1ddf=b9801(e7fb1("\198b9:\182\188"),e7fb1("O@\241\205"));c6c7685e3.Tabs.Play=c1ddf;
dc5bbd5e(c1ddf,e7fb1("\196\132N<\194\224"));c6c7685e3.Controls.TrailToggle=c1d209d5(c1ddf,
e7fb1("3C\247\187o\140"),{Title=e7fb1("\196\1459<\140\217\203!\157\188O\r"),Description=
e7fb1("\199\139!9\141\207\204\008\149\186\027\234\232\215\164"),Callback=function(
d89eef9ebe)c2760544.Trail(d89eef9ebe,c2760544.Config.TrailColor)end});c6c7685e3.Controls.
TrailColorDropdown=c1d209d5(c1ddf,e7fb1("#F\255\196g\150]\223"),{Title=e7fb1("\196\132N<\194\224\207\019{\188\025\006"
),Values={e7fb1("\196\1459<\156\224"),e7fb1("\200q\"<\140\217"),e7fb1("\199g-<\140\217"),
e7fb1("\198\143O<\140\217"),e7fb1("\198\1422<\140\217"),e7fb1("\200\143\020<\140\217"),
e7fb1("\197})<\140\217"),e7fb1("\198\136;<\140\217"),e7fb1("\198\134\025<\140\217"),e7fb1("\198mM<\140\217"
),e7fb1("\200\143!<\140\217")},Default=e7fb1("\196\1459<\156\224"),Callback=function(fea80
)c2760544.Config.TrailColor=fea80;c2760544.SetTrailColor(fea80)end});dc5bbd5e(c1ddf,e7fb1("\197\\(:\153\190"
));c6c7685e3.Controls.AutoAttackToggle=c1d209d5(c1ddf,e7fb1("3C\247\187o\140"),{Title=
e7fb1("\200q0<\194\184\206\248\137\185\026\252\233\187\161Vf\143"),Description=e7fb1("\197]\027=\138\179\206\023`\186,\221\232\222\139Vd\139"
),Callback=function(bcf148a8f)c2760544.AutoAttack(bcf148a8f)end});c6c7685e3.Controls.
BackpackToggle=c1d209d5(c1ddf,e7fb1("3C\247\187o\140"),{Title=e7fb1("\197^2<\134\179\203\253d"
),Description=e7fb1("\197^\0269\139\210\202+\153\188\019\224\232\179kZf`w\238\135\012\157\022\196YG:\147\211\2060f\186-\249"
),Callback=function(c6a0033792)c2760544.GrabBackpacks(c6a0033792)end});dc5bbd5e(c1ddf,
e7fb1("\195\144:<\166\172"));c1d209d5(c1ddf,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196x\0299\139\221\205\012\141\1860\219\232\203|Y\134V"
),Description=e7fb1("\196c:9\178\224\203.r\185\025\225\234\194\148W\127[w\232\162\r{\249")
,Callback=function()local aff3b6=a49516();if aff3b6 then c2760544.CopyAppearance(aff3b6.
Name)end end});c1d209d5(c1ddf,e7fb1("!I\004\200r\149"),{Title=e7fb1("\199\147(9\145\198\206\248\137\185G\005\232\203|Y\134V"
),Callback=function()c2760544.RestoreAppearance()end});local b601930e1c=b9801(e7fb1("\197p\0299\141\200\203\n\135"
),e7fb1("R9\002\202h\153"));c6c7685e3.Tabs.Server=b601930e1c;dc5bbd5e(b601930e1c,e7fb1("\197a2:\159\180"
));c1d209d5(b601930e1c,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196^09\136\204\202+\153\186,\212\232\215wW{au\222\164\012\127\025"
),Callback=function()c2760544.JoinLowestServer()end});c1d209d5(b601930e1c,e7fb1("!I\004\200r\149"
),{Title=e7fb1("\196^09\136\204\202+\153\186,\212\232\203\128W{au\222\164\012\127\025"),
Callback=function()c2760544.JoinFullestServer()end});c1d209d5(b601930e1c,e7fb1("!I\004\200r\149"
),{Title=e7fb1("\200[\029<\194\194\203.r\185\025\225\233\195sViuu\237\171"),Callback=
function()c2760544.Rejoin()end});local e81ca=b9801(e7fb1("\198i\028=\160\201"),e7fb1("R9\004\200l\149M\228"
));c6c7685e3.Tabs.Ui=e81ca;dc5bbd5e(e81ca,e7fb1("\197p\0169\179\182\203\253u\188\019\n\232\194p"
));c6c7685e3.Controls.PillTextInput=c1d209d5(e81ca,e7fb1("(B\000\201w"),{Title=e7fb1("\199WF9\158\177\204\007f\185=\235"
),Default=e7fb1("\197]#9\191\167\205\006k\189-\246"),Callback=function(c86f715e)a42ac1.
SetPillText(c86f715e)end});c6c7685e3.Controls.PillStyleDropdown=c1d209d5(e81ca,e7fb1("#F\255\196g\150]\223"
),{Title=e7fb1("\199WF9\158\177\207\246l\188\025\006"),Values={e7fb1("K=\247\188w"),e7fb1("C5\002\191"
)},Default=a42ac1.Config.PillStyle==e7fb1("C5\002\191")and e7fb1("C5\002\191")or e7fb1("K=\247\188w"
),Callback=function(d6a217)a42ac1.SetPillStyle(d6a217)end});c6c7685e3.Controls.
PillReactToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"),{Title=e7fb1("\199WF9\158\177\203\002\135\185+\008\232\227\159Vi|"
),Description=e7fb1("\196\\\"<\194\174\206\244\149\185+\222\236\192jY\158et\016\157\012\162*\195\140\0168\187\178\203\247l\185+\242\231\228s"
),Default=true,Callback=function(d05f0c184)a42ac1.Config.PillReact=d05f0c184 and true or
false end});c6c7685e3.Controls.PillReactRangeSlider=c1d209d5(e81ca,e7fb1("2@\249\184h\153"
),{Title=e7fb1("\196\144I9\141\207\204\245~\185J\232\235\179iVz\136"),Description=e7fb1("\200\143(<\177\203\006\170\021"
),Min=30,Max=260,Default=96,Callback=function(c799d7e63)a42ac1.Config.PillReactRange=
c799d7e63 end});c1d209d5(e81ca,e7fb1("!I\004\200r\149"),{Title=e7fb1("\200[\029;\192\213\206\244\149\185+\222\231\228sX\156\130"
),Description=e7fb1("\196o.9\139\215\203\"n\185I\233\233\212\137U\151^v\234\188\012\151\246\195\140="
),Callback=function()a42ac1.ResetPillPosition()end});c1d209d5(e81ca,e7fb1("!I\004\200r\149"
),{Title=e7fb1("\197hF<\184\222\205\006k\189-\246\242\227nW\148_x\003\152\015i'\196o\026:\160\200\213-h"
),Callback=function()a42ac1.Minimize()end});c1d209d5(e81ca,e7fb1("!I\004\200r\149"),{Title
=e7fb1("\197U29\167\180\205\006k\189-\246"),Callback=function()a42ac1.Restore()end});
c1d209d5(e81ca,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196YC=\154\212\205\006k\189-\246"),
Description=e7fb1("\196\144I9\138\225\205\018\141\188>\248\233\200l`\155`u\230\143\rn\027\196oN8\187\167\206\248\147"
),Callback=function()da6d76f:Dialog({Title=e7fb1("\196YC=\154\212"),Content=e7fb1("\198u>9\177\193\206\023`\185\021\007\236\190\147Xt`y\241\165\012v\008\206\144/"
),Buttons={{Title=e7fb1("\197l?"),Callback=function()a42ac1.Exit()end},{Title=e7fb1("\196d6"
),Callback=function()end}}})end});dc5bbd5e(e81ca,e7fb1("\200T\018=\136\180"));c6c7685e3.
Controls.KeyboardToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"),{Title=e7fb1("\200h>;\158\191\207\242\158\188>\253"
),Description=e7fb1("\198VI<\193\186\203\246\132\1861\218\235\174\144Vi|t\012\141\014\141,\198~'9\146\202"
),Default=true,Callback=function(a39000)a42ac1.Config.KeyboardAvoid=a39000 end});c6c7685e3.
Controls.PressToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"),{Title=e7fb1("\197`\025=\149\213\204\253h\185\030\223\232\177\142Xs\143"
),Description=e7fb1("\198VI:\143\176\207\003\141\184L\238\232\229\148V\157\130w\016\172\012\150\000\196Z\0299\191\224\203\012}"
),Default=true,Callback=function(ba87b)a42ac1.Config.ButtonPress=ba87b and true or false
end});c6c7685e3.Controls.ScrollbarSlider=c1d209d5(e81ca,e7fb1("2@\249\184h\153"),{Title=
e7fb1("\197\143*9\141\207\204\014\128\187B\235\234\226l"),Min=3,Max=12,Default=6,Callback=
function(d5319f7)a42ac1.Config.ScrollBarThickness=d5319f7;for f0e89987,b2f75f9 in G["uWcTr"
](da6d76f.Root:GetDescendants())do if b2f75f9:IsA(e7fb1("27\002\195o\147O\223F\026\002\181p\140"
))then b2f75f9.ScrollBarThickness=d5319f7 end end end});local e007621d=b9801(e7fb1("\195\1471:\132\214"
),e7fb1("HB\246\195"));c6c7685e3.Tabs.Info=e007621d;dc5bbd5e(e007621d,e7fb1("\195\145,<\131\172"
));c1d209d5(e007621d,e7fb1("/5\002\181j\153G\225G"),{Title=e7fb1("\199\147)8\187\209\206\245y\186,\000"
),Value=e7fb1("4\029\202tI\147[\214MH\224\192x\154\240U\156px\212\136a\006U\157qv\235\170\012\133*\197tI9\167\219\240V\151\130u\222\172\015f\246\025\244u\002\139\r\131\002\195\142J^\232\213rVd|u\217\144\015\154*\206\144\028;\169\168\204\030\129\185\016\230\232\180|"
)});c1d209d5(e007621d,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196x\0299\139\221\006\1940\244w\018\167\012u("
),Description=e7fb1("\016\005\192\1394_\023\167\024\011"),Callback=function()if G["uZbGJ"]
then G["uZbGJ"](e7fb1("\016\005\192\1394_\023\167\024\011"));c2760544.Notify(e7fb1("\196x\0299\139\221\204\249o\185\026\243"
),e7fb1("0%\176;\193\203\203\000\150\185G\006\232\203sVg\138"),2)end end});c1d209d5(
e007621d,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196x\0299\139\221\202.{\188\016\217\232\183s"
),Callback=function()if G["uZbGJ"]then G["uZbGJ"](e7fb1("\195\146-:\154\206\203\016\152\1860\r\232\203\154"
));c2760544.Notify(e7fb1("\196x\0299\139\221\204\249o\185\026\243"),e7fb1("\196\139B9\167\180\203\249\149"
),2)end end});c1d209d5(e007621d,e7fb1("/5\002\181j\153G\225G"),{Title=e7fb1("\197]7<\164\179\205\255\142\1852\215"
),Value=G["DkTPT"](G["zCZob"]:GetService(e7fb1("/@\241\205h\153Y")).LocalPlayer.Name)..
e7fb1("\255\150GtXp\006Wh_v\240\189\014\145 \196\139B=\131\169\207\246l\244R\011#\012p\025\198hK<\164\204\202)`\244\006\1341_\020\167"
)});dc5bbd5e(e007621d,e7fb1("%@\005\185q\155"));c1d209d5(e007621d,e7fb1("/5\002\181j\153G\225G"
),{Title=e7fb1("\196\145#9\140\180\203\251\127\188M\017\233\196\139W\153d"),Value=G["DkTPT"
](c5f0ec02a0 or e7fb1("\197p:;\162\204"))..e7fb1("\233\189$\213\232\213\128\171\255")..
d9591ef7.Tag..e7fb1("\255\150Gt\232\181\133V\134_\176")..G["DkTPT"](d9591ef7.Bytes)..e7fb1("\255\185=\235\235\177h\145\161\139\176;\191\186\203\030w\185G\006\233\176y\145\016\004\1769\167\171\206\018\132\184H\213"
)});c1d209d5(e007621d,e7fb1("!I\004\200r\149"),{Title=e7fb1("\197\140\021:\145\176\006\183KI\245\194wG\205-r\185=\236"
),Description=e7fb1("\195\140\027:\175\200\203\001\142\185\026\252\231\227\128Zfav\234\179\011\158\252\199\145M=\151\168\203\031y\187\025\220"
),Callback=function()G["GdwfY"](function()if G["iXxhM"](G["qgLIj"])==e7fb1("EI\254\183w\144U\223"
)then G["qgLIj"](f9dfb19)end end);c2760544.Notify(e7fb1("%@\005\185q\155"),e7fb1("\198\144#9\176\191\203(\145\186H\217\242\227rZfau\016\131\015j\011\197p<;\151\198\204\006g"
),3)end});if#e43de>0 then G["mzALM"](e7fb1(":\185\024\218\233\187\149\206\255\186\030\251\231\226\156W}Xu\015\189\012\138\"\199\1365t"
)..G["DkTPT"](#e43de)..e7fb1("\255\184H\254"));dc5bbd5e(e007621d,e7fb1("\199\131\026:\153\212"
));c1d209d5(e007621d,e7fb1("/5\002\181j\153G\225G"),{Title=e7fb1("\197b78\190\221\203\249z\185K\014\232\227hV\151\140"
),Value=G["DkTPT"](#e43de)..e7fb1("\255\184H\254\233\181\141U\154\138x\246\174\015\157$\199\147\023^"
)..G["VDLoz"].concat(e43de,e7fb1("\233"))})end;dc5bbd5e(f9ed2,e7fb1("\196\144\0169\136\218\206\018\132\185\021\217"
));c6c7685e3.Controls.JumpToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\199\139C<\186\170\203-_\185\021\007"
),Description=e7fb1("\196YC=\154\212\204\008\149\185+\242\232\175\150W\151\140v\220\146\012t\016\197p<;\157\171\206(\146\188G\215"
),Callback=function(ffd1ce7c)c2760544.Config.JumpOn=ffd1ce7c and true or false;e88fc7d0.
jumpOn=ffd1ce7c and true or false;local e835e61c=b668570c5b();if ffd1ce7c then c2760544.
SetJumpHeight(c2760544.Config.JumpPower or e88fc7d0.jumpValue or fec4e3);return end;if
e835e61c then G["GdwfY"](function()e835e61c.UseJumpPower=e88fc7d0.baseUseJumpPower or false
;if e835e61c.UseJumpPower then e835e61c.JumpPower=e88fc7d0.baseJumpPower or e835e61c.
JumpPower else e835e61c.JumpHeight=e88fc7d0.baseJumpHeight or e835e61c.JumpHeight end end)
end;G["GdwfY"](function()c6c7685e3.Controls.JumpSlider:SetValue(G["kURbl"].clamp(fec4e3,0,
500))end)end});c6c7685e3.Controls.GravityToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"),{
Title=e7fb1("\200[\0299\141\194\203-_\185\021\007"),Description=e7fb1("\196YC=\154\212\204\008\149\186\017\246\232\203s\145\016\r\198\1305"
),Callback=function(e1948066)c2760544.Config.GravityOn=e1948066 and true or false;if
e1948066 then c2760544.SetGravity(c2760544.Config.Gravity or 196.2)else c2760544.
SetGravity(196.2)end end});c1d209d5(f9ed2,e7fb1("!I\004\200r\149"),{Title=e7fb1("\200[\029;\192\213\203*\158\1887\230"
),Description=e7fb1("\197U29\167\180\207,w\188>\248#^\022"),Callback=function()c2760544.
SetFOV(70);c6c7685e3.Controls.FovSlider:SetValue(70)end});dc5bbd5e(f9ed2,e7fb1("\196\147;=\131\198\206(p\186=\249"
));c6c7685e3.Controls.RunSpeedInput=c1d209d5(f9ed2,e7fb1("(B\000\201w"),{Title=e7fb1("\196\147;=\131\198\206(p\186=\249\236\167\133V\153z"
),Default=e7fb1("\020\004"),Placeholder=e7fb1("\197i@9\176\190\206'i\1854\251\235\221pV\158\127"
),Callback=function(d5b5207)local ba4913950a=G["Eykza"](d5b5207);if ba4913950a then
c2760544.SetRunSpeed(ba4913950a)end end});c6c7685e3.Controls.FastRunToggle=c1d209d5(f9ed2,
e7fb1("3C\247\187o\140"),{Title=e7fb1("\196\147;=\131\198\206(p\186=\249"),Default=false,
Callback=function(f92827362)c2760544.FastRun(f92827362)end});f86178(function()local
cbb9e3bd5=-1;while true do G["mfAgK"].wait(0.5);if not(c6c7685e3.Window and c6c7685e3.
Window.Root and c6c7685e3.Window.Root.Parent)then break end;local cc77a=b668570c5b();if
cc77a then local ee7a9=G["kURbl"].floor(cc77a.WalkSpeed);if c2760544.Config.SpeedOn then
cbb9e3bd5=ee7a9 elseif ee7a9~=cbb9e3bd5 then cbb9e3bd5=ee7a9;e88fc7d0.baseSpeed=cc77a.
WalkSpeed;e88fc7d0.walkSpeed=cc77a.WalkSpeed;G["GdwfY"](function()c6c7685e3.Controls.
SpeedSlider:SetValue(G["kURbl"].clamp(ee7a9,0,350))end)end end end end);dc5bbd5e(f9ed2,
e7fb1("\200lB:\141\203"));c6c7685e3.Controls.AntiFlingToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"
),{Title=e7fb1("\200lB;\151\208\207\020}"),Description=e7fb1("\197^\0269\136\207\203\r\153\1887\230\235\176\152X\129\132v\230\161\016i.\196YC:\145\176"
),Callback=function(f15e528)c2760544.AntiFling(f15e528)end});c6c7685e3.Controls.
BypassFlyToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\198\143%<\194\174\207\020}\1881\224"
),Description=e7fb1("\196\133\031<\151\228\006\183NF\243\185V\140R\215#5\253\181j\140\213-k\189(\006\233\212\136Z\130rx\245\143\015\136\028\199\1402"
),Callback=function(cc39d197)c2760544.BypassFly(cc39d197)end});c6c7685e3.Controls.
JoinNotifyToggle=c1d209d5(f9ed2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\198b99\177\221\2060z\185\021\2492\016f\241\196[J=\131\193\205\016\132"
),Callback=function(ecec7676e)c2760544.JoinNotify(ecec7676e)end});dc5bbd5e(f9ed2,e7fb1("\197p<9\159\215\204\005\154\185\023\015"
));c1d209d5(f9ed2,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196[K:\160\167\204\250_\186,\221\231\225\160`\155\\u\002\165\rn(\198\127?C\191\176"
),Description=e7fb1("\196c:9\159\207\204\r\139\186,\014\234\187\133Wt\\"),Callback=
function()c2760544.KillAll()end});c1d209d5(f9ed2,e7fb1("!I\004\200r\149"),{Title=e7fb1("\199[::\160\167"
),Description=e7fb1("\197p<9\159\215\204\006g\186.\240"),Callback=function()c2760544.
Suicide()end});local cc4e6bcc08={name=nil};local function f1133181f()local de2b0a={};for
fc98f594c6,e57cc68759 in G["uWcTr"](d31cc4e681:GetPlayers())do if e57cc68759~=e765953e then
G["VDLoz"].insert(de2b0a,e57cc68759.Name)end end;if#de2b0a==0 then G["VDLoz"].insert(
de2b0a,e7fb1("\197k09\159\207\205+\158\187\030\253\232\213\156"))end;return de2b0a end;
dc5bbd5e(ac1c2,e7fb1("\198\128<8\189\179\202)\137\187+\002\233\199m"));local f90b0d8d=
f1133181f();c6c7685e3.Controls.Target2Dropdown=c1d209d5(ac1c2,e7fb1("#F\255\196g\150]\223"
),{Title=e7fb1("\198\128<8\189\179\205\012\141\1860\219"),Description=e7fb1("\198\143)9\193\209\205\255\142\184L\244\236\167g\145\014\244x\219\173\014\132\245\198h8"
),Values=f90b0d8d,Default=f90b0d8d[1],Callback=function(bd97a)cc4e6bcc08.name=bd97a end});
c1d209d5(ac1c2,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196\\G:\153\215\205\029\139\184J\224\234\194\148W\127[u\220\154\015\135\025"
),Callback=function()if c6c7685e3.Controls.Target2Dropdown and c6c7685e3.Controls.
Target2Dropdown.SetValues then c6c7685e3.Controls.Target2Dropdown:SetValues(f1133181f())
end end});local function b3c852c2()local a55f908a08=cc4e6bcc08.name;if not a55f908a08 or
a55f908a08==e7fb1("\197k09\159\207\205+\158\187\030\253\232\213\156")then a55f908a08=
e03cdb.name end;if not a55f908a08 or a55f908a08==e7fb1("\197k09\159\207\205+\158\187\030\253\232\213\156"
)then c2760544.Notify(e7fb1("\197c ;\167\225"),e7fb1("\196Y\024=\131\176\202)_\184H\254\234\194\148W\127[w\226\172\012\148'"
),3);return nil end;local f9f205a2=d31cc4e681:FindFirstChild(a55f908a08);if not f9f205a2
then c2760544.Notify(e7fb1("\197c ;\167\225"),e7fb1("\198b99\177\221\203(\145\1876\015\232\227f"
),3);return nil end;return f9f205a2 end;dc5bbd5e(ac1c2,e7fb1("\196\146:;\145\214\202-\127\189\016\213#V\006V\157~w\226\178\014z\026\200w."
));local e89be5e=false;c6c7685e3.Controls.LockTeleToggle=c1d209d5(ac1c2,e7fb1("3C\247\187o\140"
),{Title=e7fb1("\200h\0179\177\193\202-\127\189\016\213\242\227nY\147\136w\241\131\014\129\031\197t\023C\191\176"
),Description=e7fb1("\197\131\0319\187\206\206%\147\185\024\004\234\194\148W\127[t\012\141\r|*\255\007\176:\163\227"
),Callback=function(d36d5d)local eac79d5189=d36d5d and b3c852c2()or nil;if d36d5d and not
eac79d5189 then return false end;if d36d5d then return c2760544.LoopTeleport(e7fb1("A9\003\189g\140"
),eac79d5189.Name,3)end;c2760544.StopLoopTeleport()end});c6c7685e3.Controls.PullToggle=
c1d209d5(ac1c2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\196\146:;\145\214\204\251i\187+\002\233\199mU\155ty\212\132\015\165\248\197q5"
),Callback=function(c77b4a06)e89be5e=c77b4a06 and true or false;if not e89be5e then return
false end;local e88a4d689=b3c852c2();if not e88a4d689 then e89be5e=false;return false end;
f86178(function()local ff25a07=e88a4d689;while e89be5e do G["mfAgK"].wait();local cd9d45=
fc4c054a();local c3e784f6=ff25a07 and ff25a07.Character and ff25a07.Character:
FindFirstChild(e7fb1("'I\253\181q\150O\2131C\255\200S\136X\229"));if cd9d45 and c3e784f6
then c3e784f6.CFrame=cd9d45.CFrame+G["HchIF"].new(0,3,0)else e89be5e=false;break end end
end)end});c6c7685e3.Controls.ViewPlayerToggle=c1d209d5(ac1c2,e7fb1("3C\247\187o\140"),{
Title=e7fb1("\197s5;\159\178\205\012\141\1860\219\235\206lY\134f"),Callback=function(
f55d739e69)local b21bd710c8=f55d739e69 and b3c852c2()or nil;if f55d739e69 and not
b21bd710c8 then return false end;c2760544.ViewPlayer(f55d739e69,b21bd710c8 and b21bd710c8.
Name)end});c6c7685e3.Controls.LoopFlingToggle=c1d209d5(ac1c2,e7fb1("3C\247\187o\140"),{
Title=e7fb1("\196\146:;\145\214\205\005\136\1893\242"),Description=e7fb1("\197\131\031t4G\205\024q\187$\253\231\223fW\139uw\239\177\r\134\248"
),Callback=function(ce3961f3)local b05e4=ce3961f3 and b3c852c2()or nil;if ce3961f3 and not
b05e4 then return false end;if ce3961f3 then return c2760544.LoopFling(b05e4.Name,1)end;
c2760544.StopLoopFling()end});c6c7685e3.Controls.AimToggle=c1d209d5(ac1c2,e7fb1("3C\247\187o\140"
),{Title=e7fb1("\197`\0239\177\193\206\248\137\187.\216\234\194\148W\127["),Description=
e7fb1("\198oH:\159\225\202)_\187+\008\233\195\131Voew\239\177\r\134\248"),Callback=
function(c0c58c1)local d82c1b3c=c0c58c1 and b3c852c2()or nil;if c0c58c1 and not d82c1b3c
then return false end;c2760544.AimAt(d82c1b3c and d82c1b3c.Name,c0c58c1)end});dc5bbd5e(
ac1c2,e7fb1("\196\146:;\145\214\202-\127\189\016\213\235\222\131X\133\143"));c6c7685e3.
Controls.LoopFrontSlider=c1d209d5(ac1c2,e7fb1("2@\249\184h\153"),{Title=e7fb1("\196]\029:\153\224\206(|\1876\015"
),Min=3,Max=25,Default=3,Callback=function(e1b92b72)c2760544.Config.LoopFront=e1b92b72 end
});c6c7685e3.Controls.LoopFrontToggle=c1d209d5(ac1c2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\196\146:;\145\214\202-\127\189\016\213\232\175\150Vhav\234\188"
),Callback=function(f8fed9)local b3b508e3=f8fed9 and b3c852c2()or nil;if f8fed9 and not
b3b508e3 then return false end;if f8fed9 then return c2760544.LoopTeleport(e7fb1("EF\255\194w"
),b3b508e3.Name,c2760544.Config.LoopFront or 3)end;c2760544.StopLoopTeleport()end});
c6c7685e3.Controls.LoopAboveSlider=c1d209d5(ac1c2,e7fb1("2@\249\184h\153"),{Title=e7fb1("\196xD=\164\221\207\028w\185J\250"
),Min=4,Max=25,Default=4,Callback=function(f15b39987)c2760544.Config.LoopAbove=f15b39987
end});c6c7685e3.Controls.LoopAboveToggle=c1d209d5(ac1c2,e7fb1("3C\247\187o\140"),{Title=
e7fb1("\196\146:;\145\214\202-\127\189\016\213\232\175\150V\131\136y\245\185"),Callback=
function(e24f5)local f05f9a4457=e24f5 and b3c852c2()or nil;if e24f5 and not f05f9a4457 then
return false end;if e24f5 then return c2760544.LoopTeleport(e7fb1("@6\255\202h"),
f05f9a4457.Name,c2760544.Config.LoopAbove or 4)end;c2760544.StopLoopTeleport()end});
c6c7685e3.Controls.LoopBehindSlider=c1d209d5(ac1c2,e7fb1("2@\249\184h\153"),{Title=e7fb1("\196d\030:\153\224\206(|\1876\015"
),Min=4,Max=30,Default=4,Callback=function(a63f9b4)c2760544.Config.LoopBehind=a63f9b4 end}
);c6c7685e3.Controls.LoopBehindToggle=c1d209d5(ac1c2,e7fb1("3C\247\187o\140"),{Title=e7fb1("\196\146:;\145\214\202-\127\189\016\213\232\175\150Voby\241\165"
),Callback=function(e81e4a7e6)local b50886=e81e4a7e6 and b3c852c2()or nil;if e81e4a7e6 and
not b50886 then return false end;if e81e4a7e6 then return c2760544.LoopTeleport(e7fb1("A9\248\189q\139"
),b50886.Name,c2760544.Config.LoopBehind or 4)end;c2760544.StopLoopTeleport()end});local
c056e90=b9801(e7fb1("\195\144:<\166\172"),e7fb1("R<\249\185o\139"));c6c7685e3.Tabs.
Disguise=c056e90;dc5bbd5e(c056e90,e7fb1("\198o>:\163\174"));local d8cf6c17=nil;local f8abc5
=f9e5b2a1ee();c6c7685e3.Controls.DisgDropdown=c1d209d5(c056e90,e7fb1("#F\255\196g\150]\223"
),{Title=e7fb1("\198o>:\163\174\205\255\136\185>\n"),Description=e7fb1("Q\n\176:\159\180\206\023`\187$\252\236\204\150VrUw\014\170\011\162\027\199w\021"
),Values=f8abc5,Default=f8abc5[1],Callback=function(e4495dfb1b)d8cf6c17=e4495dfb1b end});
c1d209d5(c056e90,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196\\G:\153\215\205\255\136\185>\n\232\175}Y\128|"
),Callback=function()if c6c7685e3.Controls.DisgDropdown and c6c7685e3.Controls.
DisgDropdown.SetValues then c6c7685e3.Controls.DisgDropdown:SetValues(f9e5b2a1ee())end end
});dc5bbd5e(c056e90,e7fb1("\195\144:<\166\172"));c1d209d5(c056e90,e7fb1("!I\004\200r\149")
,{Title=e7fb1("\195\144:<\166\172\204\249o\187+\002\233\199m`\155\\\002\138#\016\139!\196g\017;\189\206\213-h"
),Description=e7fb1("\196Y\027=\157\173\207\022\143\185#\213\236\167vU\151~w\216\141\rt\022\206\144\028\1989G\202*~\188\019\017\234\187\142"
),Callback=function()c2760544.DisguiseR6(d8cf6c17 or e03cdb.name)end});c1d209d5(c056e90,
e7fb1("!I\004\200r\149"),{Title=e7fb1("\196x\0299\139\221\205\012\141\1860\219\232\203|Y\134V\127\016\139y\023\166\206\144\025"
),Description=e7fb1(" D\000\192|kK\228BF\249\196w\144U\223\206\144\028\1984\\\006Whau\219\137"
),Callback=function()c2760544.CopyAppearance(d8cf6c17 or e03cdb.name)end});c1d209d5(
c056e90,e7fb1("!I\004\200r\149"),{Title=e7fb1("\199\147(9\145\198\206\248\137\185G\005\232\203|Y\134V"
),Description=e7fb1("\200[\029<\192\228\206\024q\188\025\006"),Callback=function()c2760544.
RestoreAppearance()end});local bf02f=b9801(e7fb1("\199X*:\159\211\203+r"),e7fb1("EC\252\184h\153"
));c6c7685e3.Tabs.Lib=bf02f;local function b8396426(d98507915,fe8d4626)return c2760544.
RunRemote(fe8d4626,d98507915)end;local function c247c(eb6b9754b,dd8d5fe62,c7706ad)c1d209d5(
bf02f,e7fb1("!I\004\200r\149"),{Title=eb6b9754b,Description=dd8d5fe62,Callback=function()
b8396426(eb6b9754b,c7706ad)end})end;dc5bbd5e(bf02f,e7fb1("\198~';\182\226\203\249v"));
c247c(e7fb1("\198~'<\135\193\204\r\139\184H\001\232\230i"),e7fb1("\195\146-:\154\206\203\016\152\1860\r\232\203\154XyXx\216\157\r\130\029\196d\024=\158\173\203\246\132\185\031\247"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\000\1924X\026\166\016\008\200\133p\157I\233Y\003\243\188x\136T\216I=\241\195e\140T\235GC\254\187{\144T\160Q9\246\1992\143K\210CG\191\193d\144T\16027\002\189s\155\020\221T5"
));c247c(e7fb1("\198~'<\135\193\204\r\139\195L\220\232\177\134Y\156\145u\237\171\022\162\250"
),e7fb1("\198~'<\135\193\204\r\139\186,\000\231\228yVitx\017\192\012\127\025"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\000\1924X\026\166\016\008\200\133p\157I\233Y\003\254\1822\153K\215R\003\248\185d\139Y\160L5\249\1942L+\168\004\021\209y<^\011\182\023\249\200\136(`'\150$\n\181\141FL'\180\004\025\197y;h\011\178\015\249\213\140(i*\150!\024\181\1538L\031\170\004\021\200\130o\156G"
));dc5bbd5e(bf02f,e7fb1("\195\140=:\153\174\206\245y\186,\000"));c247c(e7fb1("\199`\025<\145\176\205\003o"
),e7fb1("+\025\228\156Ds\019\178/\025\176\022\186G-\217NG\004\192|wO\221NH"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\221\132O\144\023\230\014\027\248\195v\155R\234/=\252\195wT\019\160Q9\246\1992\143K\210CG\191\193d\144T\160+\025\228\156Ds\019\178/\025\190\192x\136"
));c247c(e7fb1("\198n><\135\193\204\r\139"),e7fb1("W=\241\195s\144\029\168\255\187*\216\234\193\148Ycnv\240\175"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\008\189d\150V\218\022\011\191\204l\136U\225H\011\199\131p\136O\223\014%\225\1333W\024\162\015\004\192\1355T8\224A@\255\2040wO\158R7\002\189s\155\020\221T5"
));c247c(e7fb1("7\031"),e7fb1("7\031\176\156x\137"),e7fb1("GH\004\196va\021\160F=\004\188x\137\020\212NA\191\184h\157Y\221ND\255\131G}+\196\014F\241\2032\148G\218M\003\232\159(Y\022\185T6"
));c247c(e7fb1("\196cF<\135\193\204\r\139"),e7fb1("QC\242\192r\159\019\234D\244t\012\176\r|\248\255*\217\164#\015j\011\197p<"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\002\195e\147U\233\012M\245\131Tx\027\162\020\r\198\138<`\023\160Q9\246\1992\143K\210CG\191\193d\144T\1601#\210\160R\127\019\180-*\217\1640\127/\178.-\213\130o\156G"
));c247c(e7fb1("\196x,<\135\193\204\r\139"),e7fb1("X9\176\199f\153O\225S"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\198\1339[\028\168\021\008\195\1366V_\214\012G\243\198l\151Z\160Q9\246\1992\143K\210CG\191\193d\144T\160X9\181\1343\154I\227HD\004\130o\156G"
));c247c(e7fb1("\196x79\146\223\207\026\139\244\230\138"),e7fb1("C5\003\189p\136<\167"),
e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\007\188h\149N\214DF\191\184d\154O\222@J\198\131u\140L\228\014<\245\181g\154\021\222@=\254\131g\136Y\218L5\230\1381\155^\229"
));c247c(e7fb1("\199dM9\146\221\202)\140\185O\215"),e7fb1("\199dM9\146\221\202)\140\185O\215\233\222\157W\150Zw\221\139"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\251\198o\151R\160#9\243\189g\156U\230R\001\243\185q\155K\227\012 \227\131p\136O\223\014\249\213\140(`\022\150!\024\181\1538L\030\183\004\022\198yH[\011\179\023\249\209\152(l\027\150!\026\181\1406L+\167\004\022\199yE^\011\182\021\249\210\139(_\028\159SL\004"
));c247c(e7fb1("7\031\176<\135\193\204\r\139\184H\001\232\230i"),e7fb1("!\029\222\190l\136U\145\198n\020t[r\006W{\128t\017\150"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\210\157Q\145O\210N6\n\2049V(\186->\249\181rVS\210HB\191\172NUR\230@"
));c247c(e7fb1("!'\176<\135\193\204\r\139\188M\015\236\174uXh\\"),e7fb1("!'\189\192r\157K\228>M\255\201"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\006\182{\141N\212C\003\210\1672\153K\215R\003\248\185d\139Y\160L5\249\1942i9\158KC\006\185v\134_\224T\002\004\204w"
));c247c(e7fb1("1\022"),e7fb1("16\189\156x\137"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\233\201q\142K\223FL\249\1942\153U\211KC\008\131u\140L\228\014<\245\181g\154\021\222@=\254\131U\137\019\185T6"
));c247c(e7fb1("\197U <\135\193\204\r\139"),e7fb1("\198oD:\145\204\204\250r\185\026\244\235\228\163Vx|\127\016\143\015\157$\199\147\023;\172\225\206.\139\188G\007"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\251\195q\142H\210-\022\191\1414^\030\160Q9\246\1992\143K\210CG\191\193d\144T\160\004\025\198y;X\011\170\015\249\213\140(_\026\150\024\021\181\1539L\031\180\004\021\211yH\\\011\169 \249\209\132(l\030\150!\024\181\150GL+\166\004\r\201yD_"
));c247c(e7fb1("\200\143!;\156\228\206\245y\186,\000"),e7fb1("\200\143!;\156\228\206\245y\186,\000\232\177\134Y\156\145u\237\171"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\004\186f\160M\231TB\242\189q\139\021\178OD\252\1852\148G\218M\003\181\153<L(\179\004\r\193yH^\011\170\024\249\210\152(l\030\150\023\008\181\141DL+\167\004\r\211yDj\011\182\020\249\200\149(h\022\150$\012\181\150GL(\181\004\025\197y<`\011\178\023"
));dc5bbd5e(bf02f,e7fb1("\197\13589\136\204\203\n\135\185G\249\232\172\157"));c247c(e7fb1("\197]7<\164\179\006\181DL"
),e7fb1("#9\008\127.G\206&c\186J\228\233\220uY\134\\u\237\171"),e7fb1("GH\004\196va\021\160F=\004\188x\137\020\212NA\191\149]\128Y\184HH\248\201eV*\214W$\252\201vwR\230R\003\002\185o\140G\228DG\191\192d\155K\228S\003\244\195z\149R\224@8\191\195x\155\020\221T5"
));c247c(e7fb1("\197]7<\164\179\006\227RD\t"),e7fb1("2=\253\196o\1409\225X\244\230\135"),
e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\249\194i\160O\215E\003\242\181f\146[\225\014A\241\189qV9\218LD\252\185V\151_\199\018\003\253\181l\149\020\221T5"
));c247c(e7fb1("\197]7<\164\179\006\180RD\t"),e7fb1("\"C\242\181o\155\006Y\158pw\252\142\014\129\002\197b7"
),e7fb1("GH\004\196va\021\160F=\004\192d\137\020\212NA\191\201s\144U\160BC\242\181o\155\021\158\014F\245\192h\136Y\214R\003\000\185u\148G\221HB\251\131o\136Z\214RH\191\184r\158T\221N5\244\1992jU\211@@\004\130o\156G\230"
));c247c(e7fb1("\197]7<\164\179\006\222C9\008"),e7fb1("L8\245\204"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\249\194i\160O\215E\003\242\181f\146[\225\014A\241\189qVJ\214W\002\252\201d"
));local d9340a7=b9801(e7fb1("\197\140H:\139\182\206\245y\186,\000"),e7fb1("F5\253\185s\136J\158\017"
));c6c7685e3.Tabs.Games=d9340a7;local function b4dec(c2f0d3ec9,e11c0,b77ea499b0)c1d209d5(
d9340a7,e7fb1("!I\004\200r\149"),{Title=c2f0d3ec9,Description=e11c0,Callback=function()
c2760544.RunRemote(b77ea499b0,c2f0d3ec9)end})end;dc5bbd5e(d9340a7,e7fb1("F6"));b4dec(e7fb1("\198\143\0319\136\223\203\021\134\189K\216\234\176\127"
),e7fb1("&\022\190\156Xi\006X\154cu\217\187\014o\249"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\000\1924X\026\166\016\008\200\133p\157I\233Y\003\233\185o\147U\232SC\255\200kVX\214EG\191\188h\136J\228\014A\241\189qV-\179\r\028\229\150"
));b4dec(e7fb1("\196Z+9\158\201\203\253d\1863\212\233\220q"),e7fb1("&\022\216\169EG\203\247z\185+\246\232\179k"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\000\1924X\026\166\016\008\200\133p\157I\233Y\003\220\185j\144U\162\024\011\191\198h\141Y\160G9\241\184vVS\210HB\191\155Eo;\179\r@\005\181"
));b4dec(e7fb1("\198\143%<\194\174\207\020}\1881\224"),e7fb1("&\022\1768\187\186\205\005\135\1893\242\235\200r"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\000\1924X\026\166\016\008\200\133p\157I\233Y\003\247\182i\147_\160Q9\246\1992\143K\210CG\191\193d\144T\160E@\t\130o\156G"
));b4dec(e7fb1("\198h9=\166\197"),e7fb1("&\022\176;\151\208\207\020}\195L\220s\136Y\229D:\tC\191\176"
),e7fb1("GH\004\196va\021\160O5\003\200h\141_\159@D\000\131{v>\186),\002\1412\153G\232"));
dc5bbd5e(d9340a7,e7fb1("\198o!;\142\216\202+\153\187$\243"));b4dec(e7fb1("\198o!;\142\216\202+\153\187$\243\229\184\134"
),e7fb1("KC\241\184h\153\006Xh\\"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\246\1357\151\031\215G\007\241\1362U^\234Y\003\002\185i\154\021\217D5\244\1992\148G\218M\003\252\195d\139K\227\r@\005\181"
));b4dec(e7fb1("\198o!;\142\216\202+\153\187$\243\229\184\135"),e7fb1("QG\243\198l\151Z\228\255\187\025\220"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\254\192}\161V\227N\003\002\199f\153O\225SG\191\198h\141Y\160G9\241\184vVS\210HB\191\196u\144Y\224M@\249\186h"
));dc5bbd5e(d9340a7,e7fb1("\197p\0169\191\225\204\249w\185,\014"));b4dec(e7fb1("U9\008\195q\143[\211"
),e7fb1("\200p\016<\169\168\206\024\130\185\029\245"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\212\189r\154*\218\014*\245\204r\149.\230A\003\002\185i\154\021\217D5\244\1992\148G\218M\003\230\185{\150T\185T6"
));b4dec(e7fb1("3'\2106\148\199"),e7fb1("O<\241\194w\136Y\222"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\251\185<[\028\161\018\r\196\129g\150Z\160T;\249\1912\153K\215R\003\248\185d\139Y\160L5\249\1942\151N\210MH\241\199pUR\230@"
));b4dec(e7fb1("\198}O9\165\192\207\241n\1887\218"),e7fb1("\196d\0288\190\186\203+r\244R\011#\r}\017\195\142\028<\186\218"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\243\205w\145\029\168\022=\191\152h\147O\231DF\189\200k\153U\230F<\189\200k\140\019\232@@\252\129s\140X\228O9\243\200l\157K\160L5\249\1942L+\165\004\022\211yDW\011\182\024\249\200\132(_\023\150$\011\181\149<L(\183\004\025\197yDY\011\170\024\249\213\141(_\022\150\023\026\181\153;L'\168\004\012\198"
));b4dec(e7fb1("\199\147,;\171\178\204\250r\184J\014"),e7fb1("2\029\223\162#l2\197-\021\221tD{2\1782\029\209"
),e7fb1("GH\004\196va\021\160Q5\007\199f\153O\225SG\190\194h\155\021\227@K\191\168k\140\019\196SF\255\194j\140Y\229\012\022\241\200w\147K\216QC\005\194g\154\019\196(#\222\129Hs:\191 !\189\149Ws'\196(\021\189\1384X\028\169"
));b4dec(e7fb1("\199m*;\172\225\205\024q\186-\212"),e7fb1("O5\003\200h\141_\145\198]\024")
,e7fb1("GH\004\196va\021\160O5\003\200h\141_\159@D\000\131Ul6\224@\026\231\1512\153G\232")
);dc5bbd5e(d9340a7,e7fb1("CC\255\198v"));b4dec(e7fb1("#C\255\198v\tw\017"),e7fb1(" 6\t\199d\147R\180NB\004\189q\156K\213"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\221\181{wO\220@5\191\149e\160Y\210K@\211\195q\155O\223T9\244\131u\140L\228\014<\245\181g\154\021\222@=\254\131Gv5\1952"
));b4dec(e7fb1("#C\255\198v\tw\018"),e7fb1("#C\255\198vG(\230S\244\212\185f\140T\229\255\186\025\223\233\195\160Xh\\"
),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\219\157Qn.\198!\004\193\131E\147G\212J\031\249\194jTU\211E\003\253\181l\149\021\181NC\002\199(Y\022\179TH\181\1343kK\212DB\004y5W3\224A=\252\185"
));b4dec(e7fb1("#C\255\198v\tw\019"),e7fb1("LG\248\181{OV\227N<\241\204,"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\241\200q\140]\163\015\006\197\131F\143O\223DG\245\129v\138X\218OH\003\131u\140L\228\014<\245\181g\154\021\222@=\254\131p\154N\210W\252\000\198r\143G\233\008\002\004\204w"
));dc5bbd5e(d9340a7,e7fb1("\198\127.8\189\176\203 \152\186\025\223"));b4dec(e7fb1("\198\127.8\189\176\203 \152\186\025\223\229\184\135"
),e7fb1("6\005\252\200hnG\222D\244x\219\173\014\132\245"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\231\133o\155K\184@A\245\173WV=\162KH\245\155d\148K\158'I\242\129E\140Y\229\012&\249\202d\147Y\158 =\253\182r\155\019\196BF\249\196wT4\192\012\031\213\1730VX\214EG\191\188h\136J\228\014A\241\189qVY\212Q=\000\200"
));dc5bbd5e(d9340a7,e7fb1("\196UG<\184\215\202)_\184H\254\235\194q"));b4dec(e7fb1("\196UG<\184\215\202)_\184H\254\235\194qSpu"
),e7fb1("\199X*:\159\211"),e7fb1("GH\004\196va\021\160Q5\007\130j\144Z\217T6\005\199h\153I\224MH\245\194wUI\224L\003\001\1974Y\024\166\021\t\198\1384V\019\160Q9\246\1992\143K\210CG\191\193d\144T\160\004\025\200y;[\011\170 \249\213\138(h*\150 \t\190\192x\136"
));dc5bbd5e(d9340a7,e7fb1(",!\194"));b4dec(e7fb1(",!\1946\148\199"),e7fb1("NB\t\204v\138X\218OH\003"
),e7fb1("GH\004\196va\021\160NB\t\204v\138X\218OH\003\130{\160`"));local ce79f210a3=e7fb1("\197p:;\162\204"
);G["GdwfY"](function()if G["iXxhM"](G["llVRo"])==e7fb1("EI\254\183w\144U\223")then
ce79f210a3=G["DkTPT"](G["llVRo"]())end end);dc5bbd5e(e007621d,e7fb1("\199\147 <\164\179\205\255\142\1852\215"
));c1d209d5(e007621d,e7fb1("/5\002\181j\153G\225G"),{Title=e7fb1("\196\145#9\140\180\205\255\142\1852\215"
),Value=e7fb1("\197\13589\136\204\203\n\135\014\176")..ce79f210a3..e7fb1("\233\187$\252\233\175\157Voa\202t"
)..e765953e.Name..e7fb1("\233\187K\236\232\175\156\171\255&\255\182o\150^\145&)\217C\191\175,\221T9\254\200S\147[\228\206\144\025"
)});dc5bbd5e(e007621d,e7fb1("\197\139G:\186\173\203\n\135"));local a68e43dd9={{e7fb1("\196x\0299\139\221\006\232D5\002\185g\140\\\228\rB\245\200"
),e7fb1("GH\004\196va\021\160V9\241\198h\139K\231R\002\254\185wVU\211EI\003\183d\155U\227"
)},{e7fb1("\196x\0299\139\221\006Vdax\008\188G2\230Q5\000\188"),e7fb1("GH\004\196va\021\160II\254\191l\140\019\213DJ\245\192r\151S\214MH\190\184hV"
)},{e7fb1("\196x\0299\139\221\006\189TF\241\196k"),e7fb1("GH\004\196va\021\160KI\002\1811\151N\160"
)},{e7fb1("\196x\0299\139\221\006\222NC\254\202h\144R"),e7fb1("GH\004\196va\021\160LC\255\194y\140O\221\r7\243"
)},{e7fb1("\196x\0299\139\221\006\216NC\246\205v\138G\229NF"),e7fb1("GH\004\196va\021\160FC\255\186|\154I\210SC\002\130o\156G\159BN\191"
)}};for c19cb8a,f33fc in G["uWcTr"](a68e43dd9)do c1d209d5(e007621d,e7fb1("!I\004\200r\149"
),{Title=f33fc[1],Callback=function()if G["uZbGJ"]then G["uZbGJ"](f33fc[2]);c2760544.
Notify(e7fb1("\196x\0299\139\221\204\249o\185\026\243"),f33fc[2],2)end end})end;c1d209d5(
e007621d,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196x\0299\139\221\006\190NC\254\199h\138\006\199\018\195L\220\232\182sW\150\139v\011\137\022\162\250"
),Callback=function()if G["uZbGJ"]then G["uZbGJ"](e7fb1("\r;\247\1315\\S\228"));c2760544.
Notify(e7fb1("\196x\0299\139\221\204\249o\185\026\243"),e7fb1("\196\139B9\167\180\203\249\149"
),2)end end});c1d209d5(e007621d,e7fb1("!I\004\200r\149"),{Title=e7fb1("\196x\0299\139\221\006\200D\021\002\185G\136H\228\206\144\0249\146\180\204(\150\186G\218\242\227o"
),Callback=function()if G["uZbGJ"]then G["uZbGJ"](e7fb1("\r;\247\131w\143X\214@8\245\184")
);c2760544.Notify(e7fb1("\196x\0299\139\221\204\249o\185\026\243"),e7fb1("\196\139B9\167\180\203\249\149"
),2)end end});c1d209d5(e007621d,e7fb1("!I\004\200r\149"),{Title=e7fb1("\197w\029:\159\207"
),Description=e7fb1("\016\005\196\1374[\006VdWv\221\144\011\159!\196\146'9\139\215"),
Callback=function()if G["uZbGJ"]then G["uZbGJ"](e7fb1("\197w\029:\159\207"));c2760544.
Notify(e7fb1("\196x\0299\139\221\204\249o\185\026\243"),e7fb1("\197w\029:\159\207"),2)end
end});dc5bbd5e(e007621d,e7fb1("\200T\0169\138\225"));c6c7685e3.Controls.KickReasonInput=
c1d209d5(e007621d,e7fb1("(B\000\201w"),{Title=e7fb1("\200T\0169\138\225\203\255~\185+\244"
),Default=e7fb1("\195\14509\186\217\207\241_\185\023\014\233\223\158Wgc"),Placeholder=
e7fb1("\200h)<\178\214\202,\130\1870\213#Y\029\168"),Callback=function(dc8fa)c2760544.
Config.KickReason=dc8fa end});c1d209d5(e007621d,e7fb1("!I\004\200r\149"),{Title=e7fb1("\199\14029\138\225\213-g\187$\252\231\223pZ|vw\238\135\012t\016\196o0C\191\176"
),Callback=function()c2760544.Kick(c2760544.Config.KickReason or e7fb1("\195\14509\186\217\207\241_\185\023\014\233\223\158Wgc"
))end});c1d209d5(e007621d,e7fb1("!I\004\200r\149"),{Title=e7fb1("\017\n\199t\233\189\147V\155T"
),Description=e7fb1("\196\1406=\151\192\206 \142\184K\247\234\199g\145\017\n\199"),
Callback=function()c2760544.Kick267(e7fb1("\197]\0279\141\207\206\024\133\185\031\229"))
end});dc5bbd5e(e007621d,e7fb1("\199\132\019<\178\188"));c1d209d5(e007621d,e7fb1("!I\004\200r\149"
),{Title=e7fb1("\200[\029:\153\215\204\255\132\187>\245\234\188rZ|v\127\016\139hZ\229@7\248\149o\147\213-h"
),Callback=function()local a82f326=a42ac1.AttachAll();c2760544.Notify(e7fb1("\198i\028=\160\201"
),e7fb1("\196\139B:\145\204\205\031\128\244")..G["DkTPT"](a82f326),2)end});c1d209d5(
e007621d,e7fb1("!I\004\200r\149"),{Title=e7fb1("\197]#9\144\215\203\000\142\187$\252#h6\186"
),Description=e7fb1("\199\146#9\138\225\203\249\143\186\030\251\232\175\156Vn\132"),
Callback=function()c2760544.Help()end});dc5bbd5e(e81ca,e7fb1("\198\147K<\178\184"));
c6c7685e3.Controls.TranslateToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"),{Title=e7fb1("\198i\028=\160\201\2050\154\188?\229"
),Description=e7fb1("\197^\026<\142\216\204\007f\244\229\157#\016f\001\197q1<\178\184\204\249o\184H\001\233\189m"
),Callback=function(eed938bf61)c2760544.TranslateUI(eed938bf61)end});c6c7685e3.Controls.
TranslateSpeedSlider=c1d209d5(e81ca,e7fb1("2@\249\184h\153"),{Title=e7fb1("\198\147K<\178\184\207\241~\185J\250"
),Description=e7fb1("\200\143(<\177\203\006\163"),Min=1,Max=5,Default=2,Callback=function(
c4f8d13745)c2760544.Config.TranslateSpeed=c4f8d13745 end});dc5bbd5e(e81ca,e7fb1("\196\140\0199\180\167\202)m\185\026\252\234\187\161"
));c6c7685e3.Controls.KeepPosToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"),{Title=e7fb1("\199\130@8\192\182\205\027v\185\031\247\231\228sX\156\130"
),Description=e7fb1("\197_&9\139\215\203\004\137\185@\005\232\168\130Vr~\127\016\143\016m\254\197b\"9\149\179\203\249f\1891\t\231\223sVeau\016\188\012\129\015\195\140==\154\219"
),Default=true,Callback=function(ce01b99)a42ac1.Config.KeepWindowPos=ce01b99 and true or
false;if not ce01b99 then a42ac1.WindowPos=nil end end});c1d209d5(e81ca,e7fb1("!I\004\200r\149"
),{Title=e7fb1("\200[\029;\192\213\205\027v\185\031\247\232\203\141V\143ct\012\145\011\163\254\198\145>"
),Description=e7fb1("\197\140\021:\145\176\206\031\143\184M\227\234\193jV\143\142u\003\187V\202.l\187M\002\242\227rVzry\015\155\015\148\021\196\133\0218\187\212"
),Callback=function()a42ac1.WindowPos=nil;fb214.w,fb214.h,fb214.x,fb214.y=nil,nil,nil,nil;
a42ac1.Config.KeepWindowPos=true;b48d02a();G["GdwfY"](d35c425e)end});c6c7685e3.Controls.
PillDragToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"),{Title=e7fb1("\199WF9\158\177\203\000\142\186\027\234\232\177\142"
),Default=true,Callback=function(daa595)a42ac1.Config.PillDraggable=daa595 and true or
false end});c6c7685e3.Controls.TitleDragToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"),{
Title=e7fb1("\199[:;\190\191\204\017f\1892\236\233\199uWjjv\223\192"),Description=e7fb1("\019\002\194\1304G\168(\255\005\202\133#\015\157\016\197]\027C\191\179\205,t\185L\212#wR\230R\244w\238\135\015\141\023\196\133\031=\156\183\203\249\149\195L\239\232\172\153Wm]u\239\161\012\160\004\196b/:\159\211\206\018k\184H\014"
),Default=true,Callback=function(eab5bdde9)a42ac1.Config.TitleDrag=eab5bdde9 and true or
false end});c6c7685e3.Controls.SelfResizeToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"),{
Title=e7fb1("\199[:;\190\191\203\000\146\184H\223\235\206xX\155}v\232\193"),Description=
e7fb1("\019\002\194\1304G\168(\255\1887\250\233\184\158U\152sx\215\192\rz*\198~'9\146\202\203\021\134\185@\227"
),Default=true,Callback=function(ed810)a42ac1.Config.SelfResize=ed810 and true or false end
});dc5bbd5e(e81ca,e7fb1("\196x&<\170\169"));local ff5ce5715={{label=e7fb1("\197\137\021<\140\217\0063\150\244\220\189j\143Z"
),name=e7fb1("+=\247\188w")},{label=e7fb1("\197\137\021<\140\217\0063\150\244\210\181o\147U\224M"
),name=e7fb1("!5\252\192r\150T")},{label=e7fb1("\197\137\021<\140\217\0063\150\244\227\195i\155)\227D5\253"
),name=e7fb1("2C\246\200F\153K\210L")},{label=e7fb1("\197\137\021<\140\217\0063\150\244\211\192r\156J"
),name=e7fb1("\"@\255\201g")},{label=e7fb1("\197\139A<\140\217\0063\150\244\212\181u\146")
,name=e7fb1("#5\002\191")},{label=e7fb1("\197\139A<\140\217\0063\150\244\212\181u\146K\227"
),name=e7fb1("#5\002\191h\153")},{label=e7fb1("\198\142?=\190\184\0063\150\244\209\161Rs+\181"
),name=e7fb1(" !\223\160Hk")},{label=e7fb1("\197\139A<\140\217\0063\150\244\221\189g\149O\216GH"
),name=e7fb1(",=\244\194l\142N\229")},{label=e7fb1("\197\139A<\140\217\0063\150\244\223\183h\136T"
),name=e7fb1(".7\245\181q")},{label=e7fb1("\197\139A<\140\217\0063\150\244\214\195u\140Y\229"
),name=e7fb1("%C\002\185v\155")},{label=e7fb1("\197\139A<\140\217\0063\150\244\227\201q\154K\229"
),name=e7fb1("2I\254\199h\155")},{label=e7fb1("\197\139A<\140\217\0063\150\244\210\192r\150J\234"
),name=e7fb1("!@\255\195g\160")},{label=e7fb1("\196\1459<\140\217\0063\150\244\209\197x\136"
),name=e7fb1(" E\005\181")},{label=e7fb1("\196\1459<\140\217\0063\150\244\209\193h\155N\234RH"
),name=e7fb1(" A\245\200k\160Y\229")},{label=e7fb1("\196\1459<\140\217\0063\150\244\226\195v\140"
),name=e7fb1("1C\003\185")},{label=e7fb1("\196\1459<\140\217\0063\150\244\213\193h\153G\221C"
),name=e7fb1("$A\245\198d\147J")},{label=e7fb1("\196\1459<\140\217\0063\150\244\227\181s\151N\218Q9"
),name=e7fb1("25\000\196k\144X\214")},{label=e7fb1("\196\1459<\140\217\0063\150\244\215\198d\151K"
),name=e7fb1("&F\241\196h")}};local d94682={};for c464e,cd455 in G["uWcTr"](ff5ce5715)do
d94682[#d94682+1]=cd455.label end;local function c662c2354(bbab70224)for e9a7798,
e5e531ea57 in G["uWcTr"](ff5ce5715)do if e5e531ea57.name==bbab70224 then return e5e531ea57.
label end end;return nil end;c6c7685e3.Controls.AcrylicToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"
),{Title=e7fb1("\197\131+;\145\226\205\003b\195L\220D\138X\234K=\243C\191\176"),
Description=e7fb1("%@\005\185q\155\006Yf~u\012\169\014\128\245\198p/<\134\179\204\n\142\1868\245\234\218p`\155`v\221\142\r\130+\199\146\0199\147\170\203)\134\195L\239\233\187\159U\153Zx\250\132\016m\254\196\144\016;\152\179\207\014\129\186\025\225\234\187\133Wt\\"
),Default=(G["Eykza"](fb214.acrylic)or 0)==1,Callback=function(a7f0a0)fb214.acrylic=a7f0a0
and 1 or 0;b48d02a()end});c6c7685e3.Controls.ThemeDropdown=c1d209d5(e81ca,e7fb1("#F\255\196g\150]\223"
),{Title=e7fb1("\198i\028=\160\201\202)\154\1892\236"),Description=e7fb1("%@\005\185q\155\006Vmsw\232\162\015\150\244\199]B:\160\230\213-k\186%\008\232\204}Vg[v\225\165\022\162\253\195\140\029=\131\183\202)\137\186$\r\235\176\152"
),Values=d94682,Default=c662c2354(a42ac1.Config.Theme)or d94682[1],Callback=function(
dc596ef)for bfeac,effac56e in G["uWcTr"](ff5ce5715)do if effac56e.label==dc596ef then
a42ac1.ApplyTheme(effac56e.name);return end end end});dc5bbd5e(e81ca,e7fb1("\197T7<\134\228"
));c6c7685e3.Controls.PerfBreatheToggle=c1d209d5(e81ca,e7fb1("3C\247\187o\140"),{Title=
e7fb1("\199WF9\158\177\203\002\155\185 \012\232\177\142Xs\143"),Description=e7fb1("\196YC:\145\176\203\001m\184H\225\235\222wV\157~w\226\178\015\135\022\200kD"
),Default=true,Callback=function(a82b9d283)a42ac1.Config.PillBreathe=a82b9d283 and true or
false;if not a82b9d283 then G["GdwfY"](function()local b74cfbb9e=c2711 and c2711:
FindFirstChild(e7fb1("%@\005\185q\1553\224A=\252\185S\144R\221"));if b74cfbb9e then
aa3a3b2505(b74cfbb9e)end end)end end});c6c7685e3.Controls.PerfSpringToggle=c1d209d5(e81ca,
e7fb1("3C\247\187o\140"),{Title=e7fb1("\199WF9\158\177\203-\152\187@\251\232\182sZ\133\\")
,Description=e7fb1("\196YC:\145\176\203\001m\185M\015\232\225{V`pv\226\140\r\149\000\196\14079\191\224\205!\134\188>\245\234\213}"
),Default=true,Callback=function(fcec5bd)a42ac1.Config.PillSpring=fcec5bd and true or false
end});local ecfe4=0;G["GdwfY"](function()ecfe4=#da6d76f.Root:GetDescendants()end);local
b02b814d=e7fb1("\200uE;\176\229\006\162\016\244R\011#\014{\253\200q29\177\197\202/j\244")..
G["DkTPT"](ecfe4)..e7fb1("\255\184H\254");c6c7685e3.Controls.PerfInfo=c1d209d5(e81ca,e7fb1("/5\002\181j\153G\225G"
),{Title=e7fb1("\196\130.:\154\221\205\251\149\186\016\213"),Value=b02b814d..e7fb1("\233\185H\251\234\181mX\154sx\002\164\011\158\030\193T6"
)});do local fd3415e7,d5e4b,c0eb7d40cb=0,0,60;e26cc.RenderStepped:Connect(function(
cd9d4e52)fd3415e7=fd3415e7+cd9d4e52;d5e4b=d5e4b+1;if fd3415e7>=1.5 then c0eb7d40cb=G["kURbl"
].floor(d5e4b/fd3415e7);fd3415e7,d5e4b=0,0;G["GdwfY"](function()local eee2c=c6c7685e3.
Controls.PerfInfo;if eee2c.SetContent then eee2c:SetContent(b02b814d..e7fb1("\233\185M\231\232\176sV\151{w\226\138G"
)..G["DkTPT"](c0eb7d40cb)..e7fb1("\255:\000\199"))elseif eee2c.SetDesc then eee2c:SetDesc(
b02b814d..e7fb1("\233\185M\231\232\176sV\151{w\226\138G")..G["DkTPT"](c0eb7d40cb)..e7fb1("\255:\000\199"
))end end)end end)end;G["GdwfY"](d35c425e);G["GdwfY"](fa43e);G["GdwfY"](e0753,da6d76f.Root
);local function fb445(f4e329,e35fa)if not f4e329 then return end;local c8dcd03=f4e329:
FindFirstChildOfClass(e7fb1("4\029\211\195u\149K\227"));if not c8dcd03 then c8dcd03=G["UjcQq"
].new(e7fb1("4\029\211\195u\149K\227"));c8dcd03.Parent=f4e329 end;if e35fa>=999 then
c8dcd03.CornerRadius=G["eVkGt"].new(1,0)else c8dcd03.CornerRadius=G["eVkGt"].new(0,e35fa)
end end;local function b2c23f49(c20a164)if not c20a164 then return end;for c2c6d3d,f92241c
in G["uWcTr"](c20a164:GetDescendants())do if f92241c:IsA(e7fb1("27\002\195o\147O\223F\026\002\181p\140"
))then f92241c.ScrollBarThickness=6;f92241c.ScrollBarImageTransparency=0.35;G["GdwfY"](
function()f92241c.ElasticBehavior=G["oHgEP"].ElasticBehavior.WhenScrollable end)end end end
;local function cfa93b3847()local df277e=da6d76f.Root;if not df277e then return end;fb445(
df277e,16);fb445(da6d76f.ContainerCanvas,10);if da6d76f.TabHolder then for d51ec6,ded76 in
G["uWcTr"](da6d76f.TabHolder:GetChildren())do if ded76:IsA(e7fb1("39\008\200E\156Z\229NB")
)or ded76:IsA(e7fb1("%F\241\193h"))then fb445(ded76,8)end end end;local f53a2=da6d76f.
TitleBar;if f53a2 then if f53a2.Title then f53a2.Title.TextSize=14;f53a2.Title.Font=G["oHgEP"
].Font.GothamBold end;if f53a2.SubTitle then f53a2.SubTitle.TextSize=11;f53a2.SubTitle.
TextTransparency=0.45 end;local ed2e10ee0c=f53a2.TitleHolder;local f6f151a6=ed2e10ee0c and
ed2e10ee0c:FindFirstChildOfClass(e7fb1("4\029\220\189v\1552\210XC\005\200"));if f6f151a6
then f6f151a6.Padding=G["eVkGt"].new(0,2);f6f151a6.VerticalAlignment=G["oHgEP"].
VerticalAlignment.Center end;for c6d42fb7,b1c6dfa in G["uWcTr"]({f53a2.MinButton,f53a2.
MaxButton,f53a2.CloseButton})do if b1c6dfa and b1c6dfa.Frame then fb445(b1c6dfa.Frame,999)
end end end;b2c23f49(df277e)end;a42ac1.AfterTheme=cfa93b3847;G["GdwfY"](cfa93b3847);G["GdwfY"
](function()ecaa2c4.ThemeChanged:Connect(function()G["mfAgK"].defer(function()G["GdwfY"](
cfa93b3847)end)end)end);G["GdwfY"](function()local ff7246e79c=da6d76f.SelectTab;if G["mFaya"
](ff7246e79c)==e7fb1("EI\254\183w\144U\223")then da6d76f.SelectTab=function(self,a4f5adfc,...
)local ff61f252=ff7246e79c(self,a4f5adfc,...);G["mfAgK"].delay(0.2,function()G["GdwfY"](
b2c23f49,da6d76f.Root)end);return ff61f252 end end end);ddb4e4f6:GetPropertyChangedSignal(
e7fb1("5=\245\203s\150X\2292=\n\185")):Connect(function()e6f6c9(0.3)end);for aacf710=1,11
do if G["GdwfY"](function()da6d76f:SelectTab(aacf710)end)then break end end;c2760544.
Notify(e7fb1("\196\\F8\192\195\206\245y\186,\000+\014\144\008\008"),e7fb1("\196\139B9\141\199\206.\156\244\006\1361Y\020\162\255\150GtI\147[\214MH\224\192x\154\0063\150\244\193\140#\011\158,\200v("
),5);G["GdwfY"](function()dc9ee79.Finish()end);G["mzALM"](G["mLgvm"].format(e7fb1(":\187:\235`G\205\006k\189-\246\232\215\151X\154~\127\016\143\rf,\199T':\154\221\006\150\r\006\246\199"
),G["HkvmT"].clock()-a7150cb));G["GdwfY"](function()G["mzALM"](G["mLgvm"].format(e7fb1(":\187:\235`G\205\006k\189-\246\232\213\132U\157_\176ygG\202)\137\244R\011#\016\135&\198\129Nt(\139\006U\151~"
),#da6d76f.Root:GetDescendants(),11))end);G["mzALM"](e7fb1(":\187:\235`G\203(\145\185\026\244\235\228\163\145\161\139\176\154o\156K\223S\244w\221\139G\168(\255;\245\200j\140T\231\007\253\190\151k\156G\223F\244\191tj\140Z\216DB\006|,U,\221T9\254\200P\150H\218K9"
))