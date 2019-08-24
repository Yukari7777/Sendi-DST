local STRINGS = GLOBAL.STRINGS
local _SUFFIX = GLOBAL.SENDI_LANGUAGE_SUFFIX

 --STRINGS.NAMES : 지정할 이름 
 --DESCRIBE : 말하게 하는 명령어

STRINGS.CHARACTER_TITLES.sendi = "센디"
STRINGS.CHARACTER_NAMES.sendi = "센디"
STRINGS.CHARACTER_DESCRIPTIONS.sendi = "*빠르지만, 데미지와 체력이 약합니다!\n*허기를 소모하여 몸에 희미한 빛을 냅니다.\n*낮과 저녁 동안 체력을 빠르게 회복합니다!"
STRINGS.CHARACTER_QUOTES.sendi = "\"원래 세계로 돌아갈 때까지\n저의 여행은 멈추지 않을 거예요!\""

STRINGS.NAMES.SENDISEDMASK = "센디의 눈물 마스크"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDISEDMASK = "메시지가 쓰여있어..\n [더이상 아무것도 하고싶지않아]"
--센디 마스크
STRINGS.NAMES.SENDI_HAT_CROWN = "프랜드 폭시 헬멧"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_HAT_CROWN = "모두가 저를 인정해줄거에요!"
--군주의 왕관
STRINGS.NAMES.SENDI_HAT_GOGGLES = "군주의 고글"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_HAT_GOGGLES = "좋아. 이제 준비가 되었어."
--프랜드 고글
STRINGS.NAMES.SENDI_HAT_SPIDER = "스파이더 캣쿤 헬멧"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_HAT_SPIDER = "..이건 고양이다, 고양이다, 고양이다.."
--프랜드 고글



STRINGS.NAMES.SENDI_ARMOR_01 = "센디의 니트갑옷"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_ARMOR_01 = "이 머플러, 사실은 제 옷이에요!" 
--센디 아머
STRINGS.NAMES.SENDI_ARMOR_02 = "센디의 라이프아머"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_ARMOR_02 = "기존의 갑옷의 갑옷보다 조금더 튼튼하고 효율적으로 만들었어요!"
--센디 라이프 아머



STRINGS.NAMES.SENDI_RAPIER = "센디의 레이피어"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER = "제가 애용하던것과 닮은 레이피어에요!/n수제지만 예쁘죠?"
--센디 레이피어
STRINGS.NAMES.SENDI_RAPIER_WOOD = "연습용 목재 레이피어"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER_WOOD = "연습할때 쓰던걸 본따 만들었어요. 그래도 쓸만 하다구요!"
--센디 연습용 목재 레이피어
STRINGS.NAMES.SENDI_RAPIER_IGNIA = "이그니아 레이피어"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER_IGNIA = "끊임없이 타오르고있어요...\n 방대한 에너지가 느껴집니다!"
--센디 이그니아 레이피어



STRINGS.NAMES.SENDIPACK = "센디의 책가방"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDIPACK = "저로써 남아있을 수 있게 해주는 가방이에요."
--센디팩


--센디 오븐
STRINGS.NAMES.SENDI_OVEN = "센디의 오븐"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_OVEN = "한번에 구워 버리는거에요!\n여러번 구우면 귀찮잖아요?"
--센디 오두막
STRINGS.NAMES.SENDIOBJECT_HUT = "모두의 오두막" --sendiobject_hut
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDIOBJECT_HUT = "'Seed'에서 신세지던 아난님의 이모님의 저택을 재연해봤어요. \n...이그니아?"
--센디 창고
STRINGS.NAMES.SENDIOBJECT_WAREHOUSE = "모두의 창고" --SENDIOBJECT_WAREHOUSE
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDIOBJECT_WAREHOUSE = "물건이 많아져서, 한번 만들어봤어요."

--------레시피 추가


STRINGS.SENDITABNAME = "센디탭"
STRINGS.RECIPE_DESC.SENDIPACK = "냉장고 기능이 달린 가방입니다."

STRINGS.RECIPE_DESC.SENDISEDMASK = "아픈건 싫어 [높은방어율,우산]"
STRINGS.RECIPE_DESC.SENDI_HAT_CROWN = "우린 모두 친구![고기무시]"
STRINGS.RECIPE_DESC.SENDI_HAT_GOGGLES = "사막도 두렵지않아요!"
STRINGS.RECIPE_DESC.SENDI_HAT_SPIDER = "거미 심리학(거미와 친구가됩니다)"

STRINGS.RECIPE_DESC.SENDI_RAPIER_WOOD = "센디의 연습용 레이피어 입니다."
STRINGS.RECIPE_DESC.SENDI_RAPIER = "센디의 레이피어 입니다."
STRINGS.RECIPE_DESC.SENDI_RAPIER_IGNIA = "활활 타오르고 있어요![불꽃지속딜]" 

STRINGS.RECIPE_DESC.SENDI_ARMOR_01 = "따뜻하고, 몸이 가벼워집니다." 
STRINGS.RECIPE_DESC.SENDI_ARMOR_02 = "더욱 따뜻하고, 가벼워집니다." 

STRINGS.RECIPE_DESC.SENDI_OVEN = "불꽃의 마법사. 우클릭 변경[오븐+냉장고]" 
STRINGS.RECIPE_DESC.SENDIOBJECT_HUT = "아난님의 저택을 재연해봤습니다!." --SENDIOBJECT_HUT
STRINGS.RECIPE_DESC.SENDIOBJECT_WAREHOUSE = "많은 물건을 보관하세요![냉장고]" --SENDIOBJECT_HUT


if _SUFFIX == "_en" then ------------------------------------------------------영어 대사 시작

STRINGS.CHARACTER_TITLES.sendi = "Sendi"
STRINGS.CHARACTER_NAMES.sendi = "Sendi"
STRINGS.CHARACTER_DESCRIPTIONS.sendi = "*Fast but weak, gives mercy to enemy.\n*Emits glimmering by draining belly.\n*Regen health when sunlight exists."
STRINGS.CHARACTER_QUOTES.sendi = "\"My journey would never stop \nuntil I get back to my world!\""

STRINGS.NAMES.SENDISEDMASK = "Sendi's tear mask"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDISEDMASK = "It has.. its own stories."
-- 센디 마스크
STRINGS.NAMES.SENDI_HAT_CROWN = "Frand Foxy Helmet"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_HAT_CROWN = "I'm not scared anymore with my friends!"
-- 프랜드 폭시 헬멧
STRINGS.NAMES.SENDI_HAT_GOGGLES = "monarch's helmet"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_HAT_GOGGLES = "All right, I'm ready now."
--프랜드 고글
STRINGS.NAMES.SENDI_HAT_SPIDER = "Spider Catkun Helmet"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_HAT_SPIDER = "This is a cat. Cats, cats."
--스파이더 캣쿤 헬멧

STRINGS.NAMES.SENDI_ARMOR_01 = "Sendi's knit armor"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_ARMOR_01 = "This muffler, was actually mine!" 
--센디 아머
STRINGS.NAMES.SENDI_RAPIER = "Sendi Rapier"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER = "It's like my favorite Rapier! Quite pretty, isn't ya?"
--센디 레이피어
STRINGS.NAMES.SENDI_RAPIER_WOOD = "Wooden Rapier"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER_WOOD = "I made what I used to practice which is.. Practical!"
--센디 연습용 목재 레이피어
STRINGS.NAMES.SENDI_RAPIER_IGNIA = "Ignia Rapier"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER_IGNIA = "It's Rapier which has realized the power of Ignia! Is it a bit violent?"
--센디 이그니아 레이피어
STRINGS.NAMES.SENDIPACK = "Sendi's school bag"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDIPACK = "Cute Bag, it even cools stuff! Science is brilliant!"
--센디팩
STRINGS.NAMES.SENDI_ARMOR_02 = "Sendi's Life armor"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_ARMOR_02 = "I made it a bit more durable and efficient than the previous!"
--센디 오븐
STRINGS.NAMES.SENDI_OVEN = "Sendi Oven"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_OVEN = "Bake it all at once! It's annoying to bake it many times, right?"
--센디 오두막
STRINGS.NAMES.SENDIOBJECT_HUT = "Everyone's cabin"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDIOBJECT_HUT = "I've reenacted my old mansion."
--센디 창고
STRINGS.NAMES.SENDIOBJECT_WAREHOUSE = "Everyone's warehouse"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDIOBJECT_WAREHOUSE = "I've reenacted my old mansion."


--wharang_shrine
STRINGS.SENDITABNAME = "Sendi Tab"
STRINGS.RECIPE_DESC.SENDIPACK = "Sendi's white school bag."
STRINGS.RECIPE_DESC.SENDISEDMASK = "A mask with a sad story."
STRINGS.RECIPE_DESC.SENDI_HAT_CROWN = "We are friend.[no meat]"
STRINGS.RECIPE_DESC.SENDI_HAT_GOGGLES = "[I'm not afraid of the desert anymore]."
STRINGS.RECIPE_DESC.SENDI_HAT_SPIDER = "[make friends with spiders]."
STRINGS.RECIPE_DESC.SENDI_RAPIER_WOOD = "Practice rapier."
STRINGS.RECIPE_DESC.SENDI_RAPIER = "Sendi's Rapier"
STRINGS.RECIPE_DESC.SENDI_ARMOR_01 = "It is warm and fast." 
STRINGS.RECIPE_DESC.SENDI_ARMOR_02 = "Too warm and fast." 
STRINGS.RECIPE_DESC.SENDI_RAPIER_IGNIA = "Loop fire damage." 
STRINGS.RECIPE_DESC.SENDI_OVEN = "Warm and cold fire"  
STRINGS.RECIPE_DESC.SENDIOBJECT_HUT = "a comfortable haven" 
STRINGS.RECIPE_DESC.SENDIOBJECT_WAREHOUSE = "a comfortable haven" 
end