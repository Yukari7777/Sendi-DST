local STRINGS = GLOBAL.STRINGS
local _SUFFIX = GLOBAL.SENDI_LANGUAGE_SUFFIX

 --STRINGS.NAMES : 지정할 이름 
 --DESCRIBE : 말하게 하는 명령어

STRINGS.CHARACTER_TITLES.sendi = "센디"
STRINGS.CHARACTER_NAMES.sendi = "센디"
STRINGS.CHARACTER_DESCRIPTIONS.sendi = "*이동속도가 빠르지만, 데미지와 체력이 약합니다!\n*허기를 소모하여 몸에 희미한 빛을 냅니다.\n*낮과 저녁 동안 체력을 빠르게 회복합니다!"
STRINGS.CHARACTER_QUOTES.sendi = "\"원래 세계로 돌아갈 때까지\n저의 여행은 멈추지 않을 거예요!\""

--------------------------------장비시작 

STRINGS.NAMES.SENDISEDMASK = "센디의 눈물 마스크"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDISEDMASK = "이 마스크엔 많은 사연이 있어요.."
--센디 마스크

---------------모자-----------------------------

STRINGS.NAMES.SENDI_ARMOR_01 = "센디의 니트갑옷"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_ARMOR_01 = "어째선지 기분이 좋아져요.\n앗, 이 머플러, 사실은 제가 입던 옷이랍니다!" 
--센디 아머
STRINGS.NAMES.SENDI_ARMOR_02 = "센디의 라이프아머"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_ARMOR_02 = "이그니아처럼 귀여운 날개를 달았어요, 어째선지 조금 더 튼튼하고 빨라진 기분이에요!"
--센디 라이프 아머

---------------갑옷-----------------------------

STRINGS.NAMES.SENDI_RAPIER_WOOD = "연습용 목재 레이피어"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER_WOOD = "연습할때 쓰던걸 본따 만들었죠.그래도 쓸만 하답니다!"
--센디 연습용 목재 레이피어
STRINGS.NAMES.SENDI_RAPIER = "센디의 레이피어"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER = "제가 애용하던것과 닮은 레이피어에요! 수제지만 예쁘지 않나요?"
--센디 레이피어
STRINGS.NAMES.SENDI_RAPIER_IGNIA = "이그니아 레이피어"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER_IGNIA = "이그니아의 힘을 실체화 시킨 레이피어에요!\n조금 과격한가요?"
--센디 이그니아 레이피어

---------------레이피어--------------------------
STRINGS.NAMES.SENDIPACK = "센디의 책가방"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDIPACK = "귀여운 가방이에요. 냉장고 기능도 겸비!\n과학은 정말 대단해요~"
--센디가방

--------------센디-----------------------------
--센디 오븐
STRINGS.NAMES.SENDI_OVEN = "센디의 오븐"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_OVEN = "한번에 구워버리는거에요! 여러번 구우면 귀찮잖아요?"
--------------오브젝트--------------------------

--------레시피 추가 [장비 관련도 묶음순]
STRINGS.SENDITABNAME = "센디탭"
STRINGS.RECIPE_DESC.SENDIPACK = "센디의 하얀 가방 입니다.[냉장고]"
STRINGS.RECIPE_DESC.SENDISEDMASK = "슬픈 사연이 담긴 마스크.[방수 25%]"
STRINGS.RECIPE_DESC.SENDI_ARMOR_01 = "머플러가 귀엽습니다.[이속+보온돌]" 
STRINGS.RECIPE_DESC.SENDI_ARMOR_02 = "보석과 날개가 돋보입니다[이속+보온돌]" 
STRINGS.RECIPE_DESC.SENDI_RAPIER_WOOD = "센디의 연습용 레이피어 입니다."
STRINGS.RECIPE_DESC.SENDI_RAPIER = "센디의 레이피어 입니다."
STRINGS.RECIPE_DESC.SENDI_RAPIER_IGNIA = "활활 타오르고 있어요![불꽃지속딜]" 
STRINGS.RECIPE_DESC.SENDI_OVEN = "이것만있으면 당신도 요리왕![오븐/냉장고]" 

if _SUFFIX == "_en" then ------------------------------------------------------영어 대사 시작

STRINGS.CHARACTER_TITLES.sendi = "Sendi"
STRINGS.CHARACTER_NAMES.sendi = "Sendi"
STRINGS.CHARACTER_DESCRIPTIONS.sendi = "*Fast but weak, gives mercy to enemy.\n*Emits glimmering by draining belly.\n*Regen health when sunlight exists."
STRINGS.CHARACTER_QUOTES.sendi = "\"My journey would never stop \nuntil I get back to my world!\""

STRINGS.NAMES.SENDISEDMASK = "Sendi's tear mask"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDISEDMASK = "It has.. its own stories."
-- 센디 마스크
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

STRINGS.SENDITABNAME = "Sendi Tab"
STRINGS.RECIPE_DESC.SENDIPACK = "Sendi's white school bag."
STRINGS.RECIPE_DESC.SENDISEDMASK = "A mask with a sad story."
STRINGS.RECIPE_DESC.SENDI_RAPIER_WOOD = "Sendi's Rapier for practice"
STRINGS.RECIPE_DESC.SENDI_RAPIER = "Sendi's Rapier"
STRINGS.RECIPE_DESC.SENDI_ARMOR_01 = "Keep it warm and get boosted!" 
STRINGS.RECIPE_DESC.SENDI_ARMOR_02 = "Upgraded Life armor" 
STRINGS.RECIPE_DESC.SENDI_RAPIER_IGNIA = "It's flamming!" 
STRINGS.RECIPE_DESC.SENDI_OVEN = "Sendi's oven with endothermic" 

end