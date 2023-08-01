const use_limit = false;//사용될 방을 제한할것인지에 대한것입니다. 제한을 원하시면 false를 true로 바꿔주시고 아래에 사용될 방이름을 적어주세요.

const 갠쳇 = true; //갠쳇에서도 사용을 원하시면 false를 true로 바꾸어주세요. (true로 설정시, 모든 갠쳇에서 작동됩니다.)

const using_room = ["작동할 방이름1", "작동할 방이름2", "작동할 방이름3"];//사용할 방이름을 적어주세요.

const maxturn = 25;//최대 턴수입니다. 수정하셔도 됩니다.

const use_AD = false; //%개발자 를 쳤을때 나오는 이스터에그식 제 채널 홍보성 메시지(?) 사용 여부입니다. 원치 않으신다면 false로 바꿔주세요! (true 추천)


function random(small, big) {
  return Math.floor(Math.random() * (big - small)) + small;
}
function delay(time) {
  java.lang.Thread.sleep(time);
}
const FilePath = "주사위pvp/";
const bot = ["[BOT]초보", "[BOT]중수", "[BOT]고수", "[BOT]광전사", "[BOT]보스", "[BOT]최종보스"];//봇 이름입니다. 수정하셔도 큰 상관은 없습니다. (이걸 수정하셔도 명령어는 바뀌지 않으니 참고해주세요!)
/*   전역 변수   */

var damage = {}, level = {};
var data = {};
var player1 = {};
var player2 = {};
var rand = {};
var rand2 = {};
var HP1 = {};
var HP2 = {};
var bonus1 = {};
var bonus2 = {};
var turn = {};
var NOWIN1 = {}, NOWIN2 = {};
var mod = {};
var hack = {};
var timer = {};


const ban_nick = ["<", ">", "*", "?", ":", "\"", "\n", "|", "@", "‮"];
function responseFix(room, msg, sender, isGroupChat, replier, imageDB, packageName) {
  if (!갠쳇 && !isGroupChat) 
    return;
  if (isGroupChat) {
    if (use_limit && !using_room.includes(room)) 
      return;
  }
  if (msg == "%주사위도움말") {
    replier.reply("[[도움말]]​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​\n1. 주사위PVP 설명\n-주사위 PVP는 1대 1로 주사위의 수로 플레이어 혹은 봇과 경쟁하는 봇 미니게임입니다.\n\n2. 참여 및 퇴장\n-참여는 %pvp참여 명령어이고 기권(게임 시작후)는 %기권 입니다. 게임 시작전 누가 방에 접속한 상태에서 잠수를 탈 시에는 %방비우기 명령어를 활용해주세요! 예상치 못하게 게임이 시작될 시에는 첫번째 턴이 지나기전에 %기권을 사용하시면 됩니다! 상대와의 무승부 요청은 %무승부요청 명령어를 사용해주세요! 상대도 %무승부요청을 쳐 줘야 무승부가 수락됩니다!\n\n3. 게임 진행\n3-1. 공격주사위\n-적에게 기본 1~6 의 피해를 줍니다! 둘 다 공격주사위를 사용하면 수가 더 높은 사람이 상대에게 자신의 주사위 수만큼 피해를 줍니다.\n3-2. 방어주사위\n-1~6 의 수가 나오며 적이 공격주사위 일시, (적 공격주사위 수) - (자신의 방어주사위 수) 만큼의 피해를 받으며 자신의 방어주사위가 수가 더 높으면 더 높은 만큼 HP가 회복됩니다. 방어주사위 사용 후에 공격주사위를 사용하면 공격주사위 수 + 2 의 효과를 얻습니다. 공격주사위가 8이 나올시에는 방어가 관통됩니다.\n\n4. 승패\n-인당 30의 기본 HP를 가지고 HP가 0이하가 되거나 40이상이 되면 해당 유저는 패배합니다. 또한, " + maxturn + "번째 턴이 넘어가면 자동으로 게임이 종료되면서 현 HP로 승패가 결정됩니다!\n\n5. 명령어들\n-승패 횟수 조회는 %전적 입니다 또한 %전적 (닉넴) 또는 %전적 @(닉넴) 으로 다른 사람의 전적을 볼 수 있습니다.\n%폭주모드 (공격만 사용가능, 매 공격당 +2 효과) 또는 %노말모드 (공격과 방어 모두 사용가능한 기본모드) 또는 %한방모드 (시작 HP만 1이 되는 모드), %방어모드 (시작 HP가 1이 되며, 먼저 HP가 40을 초과하면 패배하는 모드) 명령어로 게임시작전, 모드를 설정할 수 있습니다.\n\n6. 봇전\n-%초보 명령어로 초보봇과 1대 1을 할수 있게되었습니다.\n-%중수 명령어로 중수봇과 1대 1을 할수 있습니다.(중수는 기본보다 10 많은 HP를 가지고 시작합니다.)\n-%고수 명령어로 고수봇과 1대 1을 할수 있습니다.(고수봇은 뛰어난 실력으로 1을 띄우지 않습니다.)\n%광전사 명령어로 광전사봇과 1대 1을 할수 있습니다.(광전사는 공격만 하며, 매 공격마다 보너스가 적용됩니다.)\n%보스 명령어로 보스와 1대 1을 할수 있습니다.(보스는 1을 띄우지않으며 매 공격에 +2 효과가 붙습니다. 또한 피가 1이하가 되는 공격을 받으면 한번 견뎌내고 다음턴에 최후의 일격을 날립니다. 이를 버텨내면 보스는 사망합니다.)\n%최종보스 명령어로 보스와 1대 1을 할수 있습니다.(보스는 1, 2를 띄우지않으며 매 공격에 +2 효과가 붙습니다. 또한 피가 1이하가 되는 공격을 받으면 한번 견뎌내고 다음턴에 최후의 일격을 날립니다. 이를 버텨내면 최종보스는 사망합니다.)\n-봇전 시에는 턴이 바뀌지 않습니다!");
  }  else if (msg == "%전적") {
    if (DataBase.getDataBase(FilePath+sender + "의 전적") == undefined) {
      replier.reply("해당 유저의 전적이 존재하지 않습니다.");
      return;
    }
    show_R(sender, replier);
  } else if (msg.includes("%전적 @")) {
    var member = msg.replace("%전적 @", "");
    for (let i = 0; i < ban_nick.length; i++) {
      if (member.includes(ban_nick[i])) {
        replier.reply("해당 유저의 전적티 존재하지 않습니다.");
        return;
      }
    }
    if (DataBase.getDataBase(FilePath+member + "의 전적") == undefined) {
      replier.reply("해당 유저의 전적이 존재하지 않습니다.");
      return;
    }
    show_R(member, replier);
  } else if (msg.includes("%전적 ")) {
    var member = msg.replace("%전적 ", "");
    for (let i = 0; i < ban_nick.length; i++) {
      if (member.includes(ban_nick[i])) {
        replier.reply("해당 유저의 전적티 존재하지 않습니다.");
        return;
      }
    }
    if (DataBase.getDataBase(FilePath+member + "의 전적") == undefined) {
      replier.reply("해당 유저의 전적이 존재하지 않습니다.");
      return;
    }
    show_R(member, replier);
  } else if (msg == "%pvp참여") {
    if (bot.includes(sender)) {
      replier.reply("봇의 닉네임은 사용이 불가합니다!");
      return;
    }
    if (using_room.includes(sender) && !isGroupChat) {
      replier.reply("해당 닉네임은 갠쳇에서 사용이 불가능합니다.");
      return;
    }
    if (player1[room] == sender || player2[room] == sender) {
      replier.reply("이미 참여했습니다");
    } else if (data[room] == undefined) {
      if (player1[room] == undefined) {
        mod[room] = 0;
        player1[room] = sender;
        for (let i = 0; i < ban_nick.length; i++) {
          if (sender.includes(ban_nick[i])) {
            replier.reply("닉네임에 사용이 불가능한 문자인\n[ " + ban_nick[i] + " ] 이 있습니다.\n해당 문자가 있는 유저는 전적이 저장이 되지 않습니다.");
            delay(1005);
            break;
          }
        }
        replier.reply("플레이어1 : " + sender + "\n플레이어2 : 없음\n모드 : " + (mod[room] == 1 ? "폭주모드" : "노말모드"));
      } else if (player2[room] == undefined) {
        player2[room] = sender;
        for (let i = 0; i < ban_nick.length; i++) {
      if (sender.includes(ban_nick[i])) {
        replier.reply("닉네임에 사용이 불가능한 문자인\n[ " + ban_nick[i] + " ] 이 있습니다.\n해당 문자가 있는 유저는 전적이 저장이 되지 않습니다.");
        delay(1005);
        break;
      }
    }
        replier.reply("플레이어1 : " + player1[room] + "\n플레이어2 : " + sender + (mod[room] == 1 ? "\n모드 : 폭주모드" : (mod[room] == 0 ? "\n모드 : 노말모드" : "\n모드 : 한방모드")));
      } else {
        replier.reply("이미 방이 꽉찼습니다. 잠수가 있을시에는 %방비우기 를 이용해주세요");
      }
      if (player2[room] != undefined && player1[room] != undefined) {
        replier.reply("게임이 시작됩니다. 공격은 %공격 이고 방어는 %방어 입니다.\n선공 : " + player1[room] + "님, 공격 혹은 방어를 하세요!");
        HP1[room] = 30;
        HP2[room] = 30;
        if (mod[room] == 2 || mod[room] == 3) {
          HP1[room] = 1;
          HP2[room] = 1;
        }
        data[room] = 1;
        turn[room] = 1;
        timer[room] = get_time();
        if (mod[room] == 1) {
          bonus1[room] = true;
          bonus2[room] = true;
        }
      }
    }
  } else if (msg == "%폭주모드") {
    if (sender != player1[room]) {
      replier.reply("플레이어1 만 모드를 설정할수 있습니다.");
      return;
    }
    if (data[room] != undefined) {
      replier.reply("게임중에 설정할수 없습니다!");
      return;
    }
    replier.reply("모드가 폭주 모드로 설정됩니다.");
    mod[room] = 1;
  } else if (msg == "%노말모드") {
    if (sender != player1[room]) {
      replier.reply("플레이어1 만 모드를 설정할수 있습니다.");
      return;
    }
    if (data[room] != undefined) {
      replier.reply("게임중에 설정할수 없습니다!");
      return;
    }
    replier.reply("모드가 노말 모드로 설정됩니다.");
    mod[room] = 0;
  } else if (msg == "%한방모드") {
    if (sender != player1[room]) {
      replier.reply("플레이어1 만 모드를 설정할수 있습니다.");
      return;
    }
    if (data[room] != undefined) {
      replier.reply("게임중에 설정할수 없습니다!");
      return;
    }
    replier.reply("모드가 한방 모드로 설정됩니다.");
    mod[room] = 2;
  } else if (msg == "%방어모드") {
    if (sender != player1[room]) {
      replier.reply("플레이어1 만 모드를 설정할수 있습니다.");
      return;
    }
    if (data[room] != undefined) {
      replier.reply("게임중에 설정할수 없습니다!");
      return;
    }
    replier.reply("모드가 방어 모드로 설정됩니다.");
    mod[room] = 3;
  } else if (msg == "%기권") {
    if (bot.includes(sender)) 
      return;
    if (data[room] != 1 && data[room] != 2) 
      return;
    if (turn[room] == 1 && (sender == player1[room] || sender == player2[room])) {
      replier.reply("1턴이 지나지 않아 전적에 영향이 가지 않습니다.");
      player1[room] = undefined;
      player2[room] = undefined;
      data[room] = undefined;
      bonus1[room] = undefined;
      bonus2[room] = undefined;
      NOWIN1[room] = undefined;
      NOWIN2[room] = undefined;
      turn[room] = undefined;
    } else if (sender == player1[room] && bot.includes(player2[room])) {
      replier.reply(player2[room] + "을(를) 격파하는데 실패했습니다!");
      player1[room] = undefined;
      player2[room] = undefined;
      data[room] = undefined;
      bonus1[room] = undefined;
      bonus2[room] = undefined;
      turn[room] = undefined;
      NOWIN1[room] = undefined;
      NOWIN2[room] = undefined;
    } else if (sender == player1[room]) {
      replier.reply(player2[room] + "님은 승리 처리됩니다!");
      run(player2[room], player1[room], room);
    } else if (sender == player2[room]) {
      replier.reply(player1[room] + "님은 승리 처리됩니다!");
      run(player1[room], player2[room], room);
    }
    if (sender == player1[room] || sender == player2[room]) {
      player1[room] = undefined;
      player2[room] = undefined;
      data[room] = undefined;
      NOWIN1[room] = undefined;
      NOWIN2[room] = undefined;
      bonus1[room] = undefined;
      bonus2[room] = undefined;
      turn[room] = undefined;
    }
  } else if (player1[room] == sender && msg == "%초보" && data[room] == undefined) {
    if (isGroupChat) {
      replier.reply("봇전은 갠쳇에서 이용해주세요!(도배 방지)");
      return;
    }
    if (mod[room] != 0) {
      replier.reply("봇전을 시작하기위해 모드를 노말모드로 전환합니다.");
      mod[room] = 0;
    }
    replier.reply("플레이어1 : " + player1[room] + "\n플레이어2 : " + bot[0]);
    player2[room] = bot[0];
    if (player2[room] != undefined && player1[room] != undefined) {
      replier.reply("게임이 시작됩니다. 공격은 %공격 이고 방어는 %방어 입니다.\n선공 : " + player1[room] + "님, 공격 혹은 방어를 하세요!");
      HP1[room] = 30;
      HP2[room] = 30;
      data[room] = 1;
      turn[room] = 1;
    }
  } else if (player1[room] == sender && msg == "%중수" && data[room] == undefined) {
    if (isGroupChat) {
      replier.reply("봇전은 갠쳇에서 이용해주세요!(도배 방지)");
      return;
    }
    if (mod[room] != 0) {
      replier.reply("봇전을 시작하기위해 모드를 노말모드로 전환합니다.");
      mod[room] = 0;
    }
    replier.reply("플레이어1 : " + player1[room] + "\n플레이어2 : " + bot[1]);
    player2[room] = bot[1];
    if (player2[room] != undefined && player1[room] != undefined) {
      replier.reply("게임이 시작됩니다. 공격은 %공격 이고 방어는 %방어 입니다.\n선공 : " + player1[room] + "님, 공격 혹은 방어를 하세요!");
      HP1[room] = 30;
      HP2[room] = 40;
      data[room] = 1;
      turn[room] = 1;
    }
  } else if (player1[room] == sender && msg == "%광전사" && data[room] == undefined) {
    if (isGroupChat) {
      replier.reply("봇전은 갠쳇에서 이용해주세요!(도배 방지)");
      return;
    }
    if (mod[room] != 0) {
      replier.reply("봇전을 시작하기위해 모드를 노말모드로 전환합니다.");
      mod[room] = 0;
    }
    replier.reply("플레이어1 : " + player1[room] + "\n플레이어2 : " + bot[3]);
    player2[room] = bot[3];
    if (player2[room] != undefined && player1[room] != undefined) {
      replier.reply("게임이 시작됩니다. 공격은 %공격 이고 방어는 %방어 입니다.\n선공 : " + player1[room] + "님, 공격 혹은 방어를 하세요!");
      HP1[room] = 30;
      HP2[room] = 20;
      bonus2[room] = true;
      data[room] = 1;
      turn[room] = 1;
    }
  } else if (player1[room] == sender && msg == "%고수" && data[room] == undefined) {
    if (isGroupChat) {
      replier.reply("봇전은 갠쳇에서 이용해주세요!(도배 방지)");
      return;
    }
    if (mod[room] != 0) {
      replier.reply("봇전을 시작하기위해 모드를 노말모드로 전환합니다.");
      mod[room] = 0;
    }
    replier.reply("플레이어1 : " + player1[room] + "\n플레이어2 : " + bot[2]);
    player2[room] = bot[2];
    if (player2[room] != undefined && player1[room] != undefined) {
      replier.reply("게임이 시작됩니다. 공격은 %공격 이고 방어는 %방어 입니다.\n선공 : " + player1[room] + "님, 공격 혹은 방어를 하세요!");
      HP1[room] = 30;
      HP2[room] = 30;
      data[room] = 1;
      turn[room] = 1;
    }
  } else if (player1[room] == sender && msg == "%보스" && data[room] == undefined) {
    if (isGroupChat) {
      replier.reply("봇전은 갠쳇에서 이용해주세요!(도배 방지)");
      return;
    }
    if (mod[room] != 0) {
      replier.reply("봇전을 시작하기위해 모드를 노말모드로 전환합니다.");
      mod[room] = 0;
    }
    replier.reply("플레이어1 : " + player1[room] + "\n플레이어2 : " + bot[4]);
    player2[room] = bot[4];
    if (player2[room] != undefined && player1[room] != undefined) {
      replier.reply("게임이 시작됩니다. 공격은 %공격 이고 방어는 %방어 입니다.\n선공 : " + player1[room] + "님, 공격 혹은 방어를 하세요!");
      HP1[room] = 30;
      HP2[room] = 20;
      bonus2[room] = true;
      data[room] = 1;
      turn[room] = 1;
    }
  } else if (player1[room] == sender && msg == "%최종보스" && data[room] == undefined) {
    if (isGroupChat) {
      replier.reply("봇전은 갠쳇에서 이용해주세요!(도배 방지)");
      return;
    }
    if (mod[room] != 0) {
      replier.reply("봇전을 시작하기위해 모드를 노말모드로 전환합니다.");
      mod[room] = 0;
    }
    replier.reply("플레이어1 : " + player1[room] + "\n플레이어2 : " + bot[5]);
    player2[room] = bot[5];
    if (player2[room] != undefined && player1[room] != undefined) {
      replier.reply("게임이 시작됩니다. 공격은 %공격 이고 방어는 %방어 입니다.\n선공 : " + player1[room] + "님, 공격 혹은 방어를 하세요!");
      HP1[room] = 30;
      HP2[room] = 30;
      bonus2[room] = true;
      data[room] = 1;
      turn[room] = 1;
    }
  } else if (msg == "%무승부요청" && data[room] != undefined) {
    if (bot.includes(sender)) 
      return;
    if (sender == player1[room] && NOWIN1[room] == undefined) 
      NOWIN1[room] = true;
    else if (sender == player2[room] && NOWIN2[room] == undefined) 
      NOWIN2[room] = true;
    else 
      return;
    if (NOWIN1[room] == true && NOWIN2[room] == true) {
      replier.reply("무승부가 수락되었습니다.");
      nowin(player1[room], player2[room], room, replier);
      player1[room] = undefined;
      player2[room] = undefined;
      data[room] = undefined;
      bonus1[room] = undefined;
      bonus2[room] = undefined;
      turn[room] = undefined;
      NOWIN1[room] = undefined;
      NOWIN2[room] = undefined;
    } else if (bot.includes(player2[room])) {
      replier.reply(player2[room] + "을(를) 격파하는데 실패했습니다!");
      player1[room] = undefined;
      player2[room] = undefined;
      data[room] = undefined;
      bonus1[room] = undefined;
      bonus2[room] = undefined;
      turn[room] = undefined;
      NOWIN1[room] = undefined;
      NOWIN2[room] = undefined;
    } else 
      replier.reply("무승부가 요청되었습니다. 수락은 %무승부요청 입니다.");
  } else if (data[room] == undefined && msg == "%방비우기") {
    replier.reply("성공적으로 비워졌습니다.");
    NOWIN1[room] = undefined;
    NOWIN2[room] = undefined;
    player1[room] = undefined;
    player2[room] = undefined;
    data[room] = undefined;
    bonus1[room] = undefined;
    bonus2[room] = undefined;
    turn[room] = undefined;
  } else if (data[room] != undefined && msg == "%방비우기") {
    if (get_time() - timer[room] <= 30) {
      replier.reply("아직 30초를 초과하지 않았습니다.");
      return;
    }
    if (data[room] == 1) {
      replier.reply("자신의 차례에 잠수를 탄 " + player1[room] + "님은 패배처리됩니다.");
      run(player2[room], player1[room], room);
    } else if (data[room] == 2) {
      replier.reply("자신의 차례에 잠수를 탄 " + player2[room] + "님은 패배처리됩니다.");
      run(player1[room], player2[room], room);
    } else 
      return;
    NOWIN1[room] = undefined;
    NOWIN2[room] = undefined;
    player1[room] = undefined;
    player2[room] = undefined;
    data[room] = undefined;
    bonus1[room] = undefined;
    bonus2[room] = undefined;
    turn[room] = undefined;
  } else if (msg == "%개발자" && use_AD) {
    replier.reply("[ 개발자의 메시지 ]​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​\n\n안녕하세요! 주사위pvp의 제작자, 허허허 입니다! 혹시 제 봇을 재밌게 즐기시고 계신가요? 그렇다면 정말 감사할것 같네요! 현재 개인 유튜브 채널 운영중이니, 재밌게 즐기고 계시다면 아래 링크로 오셔서 구독(?)을 누르시고 계속 재밌게 즐겨주세요! 앞으로도 재미있는 미니게임을 만들어나가도록 하겠습니다. 정말 감사합니다!\n\nhttps://m.youtube.com/channel/UCb7ZaPuvhK1OeRJvsdwXuKg\n\n     -제작자 허허허");
  } else if (msg == "%공격") {
    if (data[room] == 1) {
      if (sender == player2[room]) {
        replier.reply("당신의 차례가 아닙니다!");
      } else if (sender == player1[room]) {
        if ((sender == player1[room] || sender == player2[room]) && mod[room] == 3) {
          replier.reply("방어모드 에서는 공격주사위를 사용할수 없습니다.");
          return;
        }
        timer[room] = get_time();
        replier.reply("또르륵...");
        data[room] = 5;
        rand[room] = random(-6, 0);
        var sum = "{{공격 주사위 결과}}\n";
        delay(2000);
        if (sender == "ৡৢৢ͜͡허허허ৡৢ(봇만들기 초보)" && hack[room]) {
          rand[room] = -6;
          sum += "⚅";
        } else if (rand[room] == -1) 
          sum += "⚀";
        else if (rand[room] == -2) 
          sum += "⚁";
        else if (rand[room] == -3) 
          sum += "⚂";
        else if (rand[room] == -4) 
          sum += "⚃";
        else if (rand[room] == -5) 
          sum += "⚄";
        else if (rand[room] == -6) 
          sum += "⚅";
        if (bonus1[room] == true) 
          sum += " + ⚁!";
        replier.reply(sum);
        data[room] = 2;
        //bot
        if (player2[room] == bot[0] || player2[room] == bot[1] || player2[room] == bot[3] || player2[room] == bot[4] || player2[room] == bot[5]) {
          delay(1000);
          replier.reply(player2[room] + " : %공격");
          data[room] = 5;
          replier.reply("또르륵...");
          if (player2[room] == bot[4] && HP2[room] != 1) 
            rand2[room] = random(-6, -1);
          else if (player2[room] == bot[5] && HP2[room] != 1) 
            rand2[room] = random(-6, -2);
          else if (HP2[room] == 1 && (player2[room] == bot[4] || player2[room] == bot[5])) 
            rand2[room] = -8;
          else 
            rand2[room] = random(-6, 0);
          var sum = "{{공격 주사위 결과}}\n";
          delay(2000);
          if (rand2[room] == -8) 
            sum += "🔟";
          if (rand2[room] == -1) {
            sum += "⚀";
          } else if (rand2[room] == -2) {
            sum += "⚁";
          } else if (rand2[room] == -3) {
            sum += "⚂";
          } else if (rand2[room] == -4) {
            sum += "⚃";
          } else if (rand2[room] == -5) {
            sum += "⚄";
          } else if (rand2[room] == -6) {
            sum += "⚅";
          }
          if (bonus2[room] == true && rand2[room] != -8) 
            sum += " + ⚁!";
          data[room] = 1;
          var sum3;
          if (rand[room] == -1 || rand[room] == 1) {
            sum3 = "⚀";
          } else if (rand[room] == -2 || rand[room] == 2) {
            sum3 = "⚁";
          } else if (rand[room] == -3 || rand[room] == 3) {
            sum3 = "⚂";
          } else if (rand[room] == -4 || rand[room] == 4) {
            sum3 = "⚃";
          } else if (rand[room] == -5 || rand[room] == 5) {
            sum3 = "⚄";
          } else if (rand[room] == -6 || rand[room] == 6) {
            sum3 = "⚅";
          }
          if (bonus1[room] == true && rand[room] < 0) 
            sum3 += " + ⚁!";
          var result1 = "\xa3 합산 \xa3\n" + player1[room] + " : ";
          var hpsum = "\n" + player1[room] + "님의 HP : ";
          if (rand[room] > 0) {
            //1플레이어 방어시
            if (bonus2[room] == true) {
              rand2[room] -= 2;
            }
            if (rand2[room] <= -8) {
              result1 += "🎯관통됨!🎯\n";
              rand[room] = 0;
            } else if (rand[room] + rand2[room] > 0) 
              result1 += "🌀회피!🌀\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "🔗공격받음!🔗\n";
            else 
              result1 += "🛡막아냄!🛡\n";
            hpsum += HP1[room] + " => ";
            HP1[room] = HP1[room] + rand[room] + rand2[room];
            hpsum += HP1[room];
            result1 += player2[room] + " : ";
            if (rand2[room] == -10) 
              result1 += "🌌최후의 일격!🌌\n";
            else if (rand2[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand2[room] + rand[room] > 0) 
              result1 += "🔀빗나감!🔀\n";
            else if (rand[room] + rand2[room] == -7 || rand[room] + rand2[room] == -6) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] + rand2[room] == 0) 
              result1 += "🔄공격이 막힘!🔃\n";
            hpsum += "\n" + player2[room] + "님의 HP : ";
            if (HP1[room] > 0 && rand2[room] == -10) 
              hpsum += HP2[room] + " => 0";
            else 
              hpsum += HP2[room] + " => " + HP2[room];
          } else {
            //1플레이어 공격시
            if (bonus1[room] == true) {
              rand[room] -= 2;
              bonus1[room] = undefined;
            }
            if (bonus2[room] == true) {
              rand2[room] -= 2;
            }
            damage[room] += rand[room] + rand2[room];
            if (rand[room] > rand2[room]) 
              result1 += "🔗공격받음!🔗\n";
            else if (rand[room] != rand2[room] && rand[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] < rand2[room] && (rand[room] == -7 || rand[room] == -6)) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] < rand2[room]) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] == rand2[room]) 
              result1 += "💥충돌!💥\n";
            result1 += player2[room] + " : ";
            //player 2
            if (rand2[room] == -10) 
              result1 += "🌌최후의 일격!🌌\n";
            else if (rand[room] < rand2[room]) 
              result1 += "🔗공격받음!🔗\n";
            else if (rand[room] != rand2[room] && rand2[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] > rand2[room] && (rand2[room] == -7 || rand2[room] == -6)) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] > rand2[room]) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] == rand[room]) 
              result1 += "💥충돌!💥\n";
            if (rand[room] < rand2[room]) 
              hpsum += HP1[room] + " => " + HP1[room];
            else if (rand[room] > rand2[room]) {
              hpsum += HP1[room] + " => ";
              HP1[room] += rand2[room];
              hpsum += HP1[room];
            } else if (rand[room] == rand2[room]) 
              hpsum += HP1[room] + " => " + HP1[room];
            hpsum += "\n" + player2[room] + "님의 HP : ";
            if (rand[room] > rand2[room]) {
              if (HP1[room] > 0 && rand2[room] == -10) 
                hpsum += HP2[room] + " => 0";
              else 
                hpsum += HP2[room] + " => " + HP2[room];
            } else if (rand[room] < rand2[room]) {
              hpsum += HP2[room] + " => ";
              HP2[room] += rand[room];
              if ((player2[room] == bot[4] || player2[room] == bot[5]) && HP2[room] < 1) 
                hpsum += "1(끈질김)";
              else if (HP1[room] > 0 && rand2[room] == -10) 
                hpsum += "0";
              else 
                hpsum += HP2[room];
            } else if (rand[room] == rand2[room]) 
              hpsum += HP2[room] + " => " + HP2[room];
          }
          data[room] = 1;
          if (rand2[room] != -10 && (player2[room] == bot[4] || player2[room] == bot[5]) && HP2[room] <= 0) 
            HP2[room] = 1;
          if (HP1[room] > 0 && HP2[room] > 0 && turn[room] != maxturn) 
            hpsum += "\n선공 : " + player1[room] + "님입니다!";
          replier.reply("{ " + turn[room] + "번째 턴 결과 }\n" + player1[room] + " : " + sum3 + "\n" + player2[room] + " : " + sum.replace("{{공격 주사위 결과}}\n", "") + "\n" + result1 + hpsum);
          whowin_bot(room, replier);
        }
      }
      if (player2[room] == bot[2]) {
        let j = random(0, 2);
        if (j == 0) {
          delay(1000);
          replier.reply(player2[room] + " : %공격");
          data[room] = 5;
          replier.reply("또르륵...");
          rand2[room] = random(-6, -1);
          var sum = "{{공격 주사위 결과}}\n";
          delay(2000);
          if (rand2[room] == -1) {
            sum += "⚀";
          } else if (rand2[room] == -2) {
            sum += "⚁";
          } else if (rand2[room] == -3) {
            sum += "⚂";
          } else if (rand2[room] == -4) {
            sum += "⚃";
          } else if (rand2[room] == -5) {
            sum += "⚄";
          } else if (rand2[room] == -6) {
            sum += "⚅";
          }
          if (bonus2[room] == true) 
            sum += " + ⚁!";
          var sum3;
          if (rand[room] == -1 || rand[room] == 1) {
            sum3 = "⚀";
          } else if (rand[room] == -2 || rand[room] == 2) {
            sum3 = "⚁";
          } else if (rand[room] == -3 || rand[room] == 3) {
            sum3 = "⚂";
          } else if (rand[room] == -4 || rand[room] == 4) {
            sum3 = "⚃";
          } else if (rand[room] == -5 || rand[room] == 5) {
            sum3 = "⚄";
          } else if (rand[room] == -6 || rand[room] == 6) {
            sum3 = "⚅";
          }
          if (bonus1[room] == true && rand[room] < 0) 
            sum3 += " + ⚁!";
          var result1 = "\xa3 합산 \xa3\n" + player1[room] + " : ";
          var hpsum = "\n" + player1[room] + "님의 HP : ";
          if (rand[room] > 0) {
            //1플레이어 방어시
            if (bonus2[room] == true) {
              rand2[room] -= 2;
              bonus2[room] = undefined;
            }
            if (rand2[room] == -8) {
              result1 += "🎯관통됨!🎯\n";
              rand[room] = 0;
            } else if (rand[room] + rand2[room] > 0) 
              result1 += "🌀회피!🌀\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "🔗공격받음!🔗\n";
            else 
              result1 += "🛡막아냄!🛡\n";
            hpsum += HP1[room] + " => ";
            HP1[room] = HP1[room] + rand[room] + rand2[room];
            hpsum += HP1[room];
            result1 += player2[room] + " : ";
            if (rand2[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand2[room] + rand[room] > 0) 
              result1 += "🔀빗나감!🔀\n";
            else if (rand[room] + rand2[room] == -7 || rand[room] + rand2[room] == -6) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] + rand2[room] == 0) 
              result1 += "🔄공격이 막힘!🔃\n";
            hpsum += "\n" + player2[room] + "님의 HP : ";
            hpsum += HP2[room] + " => " + HP2[room];
          } else {
            //1플레이어 공격시
            if (bonus1[room] == true) {
              rand[room] -= 2;
              bonus1[room] = undefined;
            }
            if (bonus2[room] == true) {
              rand2[room] -= 2;
              bonus2[room] = undefined;
            }
            if (rand[room] > rand2[room]) 
              result1 += "🔗공격받음!🔗\n";
            else if (rand[room] != rand2[room] && rand[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] < rand2[room] && (rand[room] == -7 || rand[room] == -6)) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] < rand2[room]) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] == rand2[room]) 
              result1 += "💥충돌!💥\n";
            result1 += player2[room] + " : ";
            //player 2
            if (rand[room] < rand2[room]) 
              result1 += "🔗공격받음!🔗\n";
            else if (rand[room] != rand2[room] && rand2[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] > rand2[room] && (rand2[room] == -7 || rand2[room] == -6)) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] > rand2[room]) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] == rand[room]) 
              result1 += "💥충돌!💥\n";
            if (rand[room] < rand2[room]) 
              hpsum += HP1[room] + " => " + HP1[room];
            else if (rand[room] > rand2[room]) {
              hpsum += HP1[room] + " => ";
              HP1[room] += rand2[room];
              hpsum += HP1[room];
            } else if (rand[room] == rand2[room]) 
              hpsum += HP1[room] + " => " + HP1[room];
            hpsum += "\n" + player2[room] + "님의 HP : ";
            if (rand[room] > rand2[room]) 
              hpsum += HP2[room] + " => " + HP2[room];
            else if (rand[room] < rand2[room]) {
              hpsum += HP2[room] + " => ";
              HP2[room] += rand[room];
              hpsum += HP2[room];
            } else if (rand[room] == rand2[room]) 
              hpsum += HP2[room] + " => " + HP2[room];
          }
          data[room] = 1;
          if (HP1[room] > 0 && HP2[room] > 0 && turn[room] != maxturn) 
            hpsum += "\n선공 : " + player1[room] + "님입니다!";
          replier.reply("{ " + turn[room] + "번째 턴 결과 }\n" + player1[room] + " : " + sum3 + "\n" + player2[room] + " : " + sum.replace("{{공격 주사위 결과}}\n", "") + "\n" + result1 + hpsum);
          whowin_bot(room, replier);
        } else {
          delay(1000);
          replier.reply(player2[room] + " : %방어");
          data[room] = 5;
          replier.reply("또르륵...");
          rand2[room] = random(2, 7);
          var sum = "{{방어 주사위 결과}}\n";
          delay(2000);
          bonus2[room] = true;
          if (rand2[room] == 1) {
            sum += "⚀";
          } else if (rand2[room] == 2) {
            sum += "⚁";
          } else if (rand2[room] == 3) {
            sum += "⚂";
          } else if (rand2[room] == 4) {
            sum += "⚃";
          } else if (rand2[room] == 5) {
            sum += "⚄";
          } else if (rand2[room] == 6) {
            sum += "⚅";
          }
          data[room] = 1;
          var sum3;
          if (rand[room] == -1 || rand[room] == 1) {
            sum3 = "⚀";
          } else if (rand[room] == -2 || rand[room] == 2) {
            sum3 = "⚁";
          } else if (rand[room] == -3 || rand[room] == 3) {
            sum3 = "⚂";
          } else if (rand[room] == -4 || rand[room] == 4) {
            sum3 = "⚃";
          } else if (rand[room] == -5 || rand[room] == 5) {
            sum3 = "⚄";
          } else if (rand[room] == -6 || rand[room] == 6) {
            sum3 = "⚅";
          }
          if (bonus1[room] == true && rand[room] < 0) 
            sum3 += " + ⚁!";
          var result1 = "\xa3 합산 \xa3\n" + player1[room] + " : ";
          var hpsum = "\n" + player1[room] + "님의 HP : ";
          if (rand[room] > 0) {
            //1플레이어 방어시
            result1 += "⛔대치!⛔\n" + player2[room] + " : ⛔대치!⛔\n";
            hpsum += HP1[room] + " => ";
            HP1[room] += rand[room];
            hpsum += HP1[room];
            hpsum += "\n" + player2[room] + "님의 HP : " + HP2[room] + " => ";
            HP2[room] += rand2[room];
            hpsum += HP2[room];
          } else {
            //1플레이어 공격시
            if (bonus1[room] == true) {
              rand[room] -= 2;
              bonus1[room] = undefined;
            }
            if (rand[room] + rand2[room] == 0) 
              result1 += "🔄공격이 막힘!🔃\n";
            else if (rand[room] + rand2[room] > 0) 
              result1 += "🔀빗나감!🔀\n";
            else if (rand[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] + rand2[room] <= -6) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "⚔공격함!⚔\n";
            hpsum += HP1[room] + " => " + HP1[room];
            result1 += player2[room] + " : ";
            if (rand[room] + rand2[room] > 0) 
              result1 += "🌀회피!🌀\n";
            else if (rand[room] == -8) {
              result1 += "🎯관통됨!🎯\n";
              rand2[room] = 0;
            } else if (rand[room] + rand2[room] < 0) 
              result1 += "🔰견디기!🔰\n";
            else 
              result1 += "🛡막아냄!🛡\n";
            hpsum += "\n" + player2[room] + "님의 HP : " + HP2[room] + " => ";
            HP2[room] = HP2[room] + rand[room] + rand2[room];
            hpsum += HP2[room];
          }
          if (HP1[room] > 0 && HP2[room] > 0 && turn[room] != maxturn) 
            hpsum += "\n선공 : " + player1[room] + "님입니다!";
          replier.reply("{ " + turn[room] + "번째 턴 결과 }\n" + player1[room] + " : " + sum3 + "\n" + player2[room] + " : " + sum.replace("{{방어 주사위 결과}}\n", "") + "\n" + result1 + hpsum);
          whowin_bot(room, replier);
        }
      }
    } else if (data[room] == 2) {
      if (sender == player1[room]) {
        replier.reply("당신의 차례가 아닙니다!");
      } else if (sender == player2[room]) {
        timer[room] = get_time();
        data[room] = 5;
        replier.reply("또르륵...");
        rand2[room] = random(-6, 0);
        var sum = "{{공격 주사위 결과}}\n";
        delay(2000);
        if (sender == "ৡৢৢ͜͡허허허ৡৢ(봇만들기 초보)" && hack[room]) {
          rand2[room] = -6;
          sum += "⚅";
        } else if (rand2[room] == -1) {
          sum += "⚀";
        } else if (rand2[room] == -2) {
          sum += "⚁";
        } else if (rand2[room] == -3) {
          sum += "⚂";
        } else if (rand2[room] == -4) {
          sum += "⚃";
        } else if (rand2[room] == -5) {
          sum += "⚄";
        } else if (rand2[room] == -6) {
          sum += "⚅";
        }
        if (bonus2[room] == true) 
          sum += " + ⚁!";
        replier.reply(sum);
        data[room] = 1;
        var sum3;
        if (rand[room] == -1 || rand[room] == 1) {
          sum3 = "⚀";
        } else if (rand[room] == -2 || rand[room] == 2) {
          sum3 = "⚁";
        } else if (rand[room] == -3 || rand[room] == 3) {
          sum3 = "⚂";
        } else if (rand[room] == -4 || rand[room] == 4) {
          sum3 = "⚃";
        } else if (rand[room] == -5 || rand[room] == 5) {
          sum3 = "⚄";
        } else if (rand[room] == -6 || rand[room] == 6) {
          sum3 = "⚅";
        }
        if (bonus1[room] == true && rand[room] < 0) 
          sum3 += " + ⚁!";
        var result1 = "\xa3 합산 \xa3\n" + player1[room] + " : ";
        var hpsum = "\n" + player1[room] + "님의 HP : ";
        if (rand[room] > 0) {
          //1플레이어 방어시
          if (bonus2[room] == true) {
            rand2[room] -= 2;
            bonus2[room] = undefined;
          }
          damage[room] += rand2[room];
          if (rand[room] + rand2[room] > 0) 
            result1 += "🌀회피!🌀\n";
          else if (rand2[room] == -8) {
            result1 += "🎯관통됨!🎯\n";
            rand[room] = 0;
          } else if (rand[room] + rand2[room] < 0) 
            result1 += "🔗공격받음!🔗\n";
          else 
            result1 += "🛡막아냄!🛡\n";
          hpsum += HP1[room] + " => ";
          HP1[room] = HP1[room] + rand[room] + rand2[room];
          hpsum += HP1[room];
          result1 += player2[room] + " : ";
          if (rand2[room] == -8) 
            result1 += "🌋파괴!🌋\n";
          else if (rand2[room] + rand[room] > 0) 
            result1 += "🔀빗나감!🔀\n";
          else if (rand[room] + rand2[room] == -7 || rand[room] + rand2[room] == -6) 
            result1 += "🔥최대피해!🔥\n";
          else if (rand[room] + rand2[room] < 0) 
            result1 += "⚔공격함!⚔\n";
          else if (rand[room] + rand2[room] == 0) 
            result1 += "🔄공격이 막힘!🔃\n";
          hpsum += "\n" + player2[room] + "님의 HP : ";
          hpsum += HP2[room] + " => " + HP2[room];
        } else {
          //1플레이어 공격시
          if (bonus1[room] == true) {
            rand[room] -= 2;
            if (mod[room] == 0) 
              bonus1[room] = undefined;
          }
          if (bonus2[room] == true) {
            rand2[room] -= 2;
            if (mod[room] == 0) 
              bonus2[room] = undefined;
          }
          damage[room] += rand[room] + rand2[room];
          if (rand[room] > rand2[room]) 
            result1 += "🔗공격받음!🔗\n";
          else if (rand[room] != rand2[room] && rand[room] == -8) 
            result1 += "🌋파괴!🌋\n";
          else if (rand[room] < rand2[room] && (rand[room] == -7 || rand[room] == -6)) 
            result1 += "🔥최대피해!🔥\n";
          else if (rand[room] < rand2[room]) 
            result1 += "⚔공격함!⚔\n";
          else if (rand[room] == rand2[room]) 
            result1 += "💥충돌!💥\n";
          result1 += player2[room] + " : ";
          //player 2
          if (rand[room] < rand2[room]) 
            result1 += "🔗공격받음!🔗\n";
          else if (rand[room] != rand2[room] && rand2[room] == -8) 
            result1 += "🌋파괴!🌋\n";
          else if (rand[room] > rand2[room] && (rand2[room] == -7 || rand2[room] == -6)) 
            result1 += "🔥최대피해!🔥\n";
          else if (rand[room] > rand2[room]) 
            result1 += "⚔공격함!⚔\n";
          else if (rand[room] == rand[room]) 
            result1 += "💥충돌!💥\n";
          if (rand[room] < rand2[room]) 
            hpsum += HP1[room] + " => " + HP1[room];
          else if (rand[room] > rand2[room]) {
            hpsum += HP1[room] + " => ";
            HP1[room] += rand2[room];
            hpsum += HP1[room];
          } else if (rand[room] == rand2[room]) 
            hpsum += HP1[room] + " => " + HP1[room];
          hpsum += "\n" + player2[room] + "님의 HP : ";
          if (rand[room] > rand2[room]) 
            hpsum += HP2[room] + " => " + HP2[room];
          else if (rand[room] < rand2[room]) {
            hpsum += HP2[room] + " => ";
            HP2[room] += rand[room];
            hpsum += HP2[room];
          } else if (rand[room] == rand2[room]) 
            hpsum += HP2[room] + " => " + HP2[room];
        }
        data[room] = 1;
        if (HP1[room] > 0 && HP2[room] > 0 && turn[room] != maxturn) 
          hpsum += "\n선공 : " + player2[room] + "님입니다!";
        delay(1000);
        replier.reply("{ " + turn[room] + "번째 턴 결과 }\n" + player1[room] + " : " + sum3 + "\n" + player2[room] + " : " + sum.replace("{{공격 주사위 결과}}\n", "") + "\n" + result1 + hpsum);
        whowin(room, replier);
      }
    }
  } else if (msg == "%방어") {
    if ((sender == player1[room] || sender == player2[room]) && mod[room] == 1) {
      replier.reply("폭주모드 에서는 방어주사위를 사용할수 없습니다.");
      return;
    }
    if (data[room] == 1) {
      if (sender == player2[room]) {
        replier.reply("당신의 차례가 아닙니다!");
      } else if (sender == player1[room]) {
        timer[room] = get_time();
        data[room] = 5;
        replier.reply("또르륵...");
        rand[room] = random(1, 7);
        var sum = "{{방어 주사위 결과}}\n";
        delay(2000);
        if (rand[room] == 1) {
          sum += "⚀";
        } else if (rand[room] == 2) {
          sum += "⚁";
        } else if (rand[room] == 3) {
          sum += "⚂";
        } else if (rand[room] == 4) {
          sum += "⚃";
        } else if (rand[room] == 5) {
          sum += "⚄";
        } else if (rand[room] == 6) {
          sum += "⚅";
        }
        replier.reply(sum);
        bonus1[room] = true;
        data[room] = 2;
        //bot
        if (player2[room] == bot[0] || player2[room] == bot[1] || player2[room] == bot[3] || player2[room] == bot[4] || player2[room] == bot[5]) {
          delay(1000);
          replier.reply(player2[room] + " : %공격");
          data[room] = 5;
          replier.reply("또르륵...");
          if (player2[room] == bot[4] && HP2[room] != 1) 
            rand2[room] = random(-6, -1);
          else if (player2[room] == bot[5] && HP2[room] != 1) 
            rand2[room] = random(-6, -2);
          else if (HP2[room] == 1 && (player2[room] == bot[4] || player2[room] == bot[5])) 
            rand2[room] = -8;
          else 
            rand2[room] = random(-6, 0);
          var sum = "{{공격 주사위 결과}}\n";
          delay(2000);
          if (rand2[room] == -8) 
            sum += "🔟";
          if (rand2[room] == -1) {
            sum += "⚀";
          } else if (rand2[room] == -2) {
            sum += "⚁";
          } else if (rand2[room] == -3) {
            sum += "⚂";
          } else if (rand2[room] == -4) {
            sum += "⚃";
          } else if (rand2[room] == -5) {
            sum += "⚄";
          } else if (rand2[room] == -6) {
            sum += "⚅";
          }
          if (bonus2[room] == true && rand2[room] != -8) 
            sum += " + ⚁!";
          data[room] = 1;
          var sum3;
          if (rand[room] == -1 || rand[room] == 1) {
            sum3 = "⚀";
          } else if (rand[room] == -2 || rand[room] == 2) {
            sum3 = "⚁";
          } else if (rand[room] == -3 || rand[room] == 3) {
            sum3 = "⚂";
          } else if (rand[room] == -4 || rand[room] == 4) {
            sum3 = "⚃";
          } else if (rand[room] == -5 || rand[room] == 5) {
            sum3 = "⚄";
          } else if (rand[room] == -6 || rand[room] == 6) {
            sum3 = "⚅";
          }
          if (bonus1[room] == true && rand[room] < 0) 
            sum3 += " + ⚁!";
          var result1 = "\xa3 합산 \xa3\n" + player1[room] + " : ";
          var hpsum = "\n" + player1[room] + "님의 HP : ";
          if (rand[room] > 0) {
            //1플레이어 방어시
            if (bonus2[room] == true) {
              rand2[room] -= 2;
            }
            if (rand2[room] <= -8) {
              result1 += "🎯관통됨!🎯\n";
              rand[room] = 0;
            } else if (rand[room] + rand2[room] > 0) 
              result1 += "🌀회피!🌀\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "🔗공격받음!🔗\n";
            else 
              result1 += "🛡막아냄!🛡\n";
            hpsum += HP1[room] + " => ";
            HP1[room] = HP1[room] + rand[room] + rand2[room];
            hpsum += HP1[room];
            result1 += player2[room] + " : ";
            if (rand2[room] == -10) 
              result1 += "🌌최후의 일격!🌌\n";
            else if (rand2[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand2[room] + rand[room] > 0) 
              result1 += "🔀빗나감!🔀\n";
            else if (rand[room] + rand2[room] == -7 || rand[room] + rand2[room] == -6) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] + rand2[room] == 0) 
              result1 += "🔄공격이 막힘!🔃\n";
            hpsum += "\n" + player2[room] + "님의 HP : ";
            if (HP1[room] > 0 && rand2[room] == -10) 
              hpsum += HP2[room] + " => 0";
            else 
              hpsum += HP2[room] + " => " + HP2[room];
          } else {
            //1플레이어 공격시
            if (bonus1[room] == true) {
              rand[room] -= 2;
              bonus1[room] = undefined;
            }
            if (bonus2[room] == true) {
              rand2[room] -= 2;
            }
            damage[room] += rand[room] + rand2[room];
            if (rand[room] > rand2[room]) 
              result1 += "🔗공격받음!🔗\n";
            else if (rand[room] != rand2[room] && rand[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] < rand2[room] && (rand[room] == -7 || rand[room] == -6)) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] < rand2[room]) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] == rand2[room]) 
              result1 += "💥충돌!💥\n";
            result1 += player2[room] + " : ";
            //player 2
            if (rand2[room] == -10) 
              result1 += "🌌최후의 일격!🌌\n";
            else if (rand[room] < rand2[room]) 
              result1 += "🔗공격받음!🔗\n";
            else if (rand[room] != rand2[room] && rand2[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] > rand2[room] && (rand2[room] == -7 || rand2[room] == -6)) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] > rand2[room]) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] == rand[room]) 
              result1 += "💥충돌!💥\n";
            if (rand[room] < rand2[room]) 
              hpsum += HP1[room] + " => " + HP1[room];
            else if (rand[room] > rand2[room]) {
              hpsum += HP1[room] + " => ";
              HP1[room] += rand2[room];
              hpsum += HP1[room];
            } else if (rand[room] == rand2[room]) 
              hpsum += HP1[room] + " => " + HP1[room];
            hpsum += "\n" + player2[room] + "님의 HP : ";
            if (rand[room] > rand2[room]) {
              if (HP1[room] > 0 && rand2[room] == -10) 
                hpsum += HP2[room] + " => 0";
              else 
                hpsum += HP2[room] + " => " + HP2[room];
            } else if (rand[room] < rand2[room]) {
              hpsum += HP2[room] + " => ";
              HP2[room] += rand[room];
              if ((player2[room] == bot[4] || player2[room] == bot[5]) && HP2[room] < 1) 
                hpsum += "1(끈질김)";
              else if (HP1[room] > 0 && rand2[room] == -10) 
                hpsum += "0";
              else 
                hpsum += HP2[room];
            } else if (rand[room] == rand2[room]) 
              hpsum += HP2[room] + " => " + HP2[room];
          }
          data[room] = 1;
          if (rand2[room] != -10 && (player2[room] == bot[4] || player2[room] == bot[5]) && HP2[room] <= 0) 
            HP2[room] = 1;
          if (HP1[room] > 0 && HP2[room] > 0 && turn[room] != maxturn) 
            hpsum += "\n선공 : " + player1[room] + "님입니다!";
          replier.reply("{ " + turn[room] + "번째 턴 결과 }\n" + player1[room] + " : " + sum3 + "\n" + player2[room] + " : " + sum.replace("{{공격 주사위 결과}}\n", "") + "\n" + result1 + hpsum);
          whowin_bot(room, replier);
        }
      }
      if (player2[room] == bot[2]) {
        let j = random(0, 2);
        if (j == 0) {
          delay(1000);
          replier.reply(player2[room] + " : %공격");
          data[room] = 5;
          replier.reply("또르륵...");
          rand2[room] = random(-6, 0);
          var sum = "{{공격 주사위 결과}}\n";
          delay(2000);
          if (rand2[room] == -1) {
            sum += "⚀";
          } else if (rand2[room] == -2) {
            sum += "⚁";
          } else if (rand2[room] == -3) {
            sum += "⚂";
          } else if (rand2[room] == -4) {
            sum += "⚃";
          } else if (rand2[room] == -5) {
            sum += "⚄";
          } else if (rand2[room] == -6) {
            sum += "⚅";
          }
          if (bonus2[room] == true) 
            sum += " + ⚁!";
          var sum3;
          if (rand[room] == -1 || rand[room] == 1) {
            sum3 = "⚀";
          } else if (rand[room] == -2 || rand[room] == 2) {
            sum3 = "⚁";
          } else if (rand[room] == -3 || rand[room] == 3) {
            sum3 = "⚂";
          } else if (rand[room] == -4 || rand[room] == 4) {
            sum3 = "⚃";
          } else if (rand[room] == -5 || rand[room] == 5) {
            sum3 = "⚄";
          } else if (rand[room] == -6 || rand[room] == 6) {
            sum3 = "⚅";
          }
          if (bonus1[room] == true && rand[room] < 0) 
            sum3 += " + ⚁!";
          var result1 = "\xa3 합산 \xa3\n" + player1[room] + " : ";
          var hpsum = "\n" + player1[room] + "님의 HP : ";
          if (rand[room] > 0) {
            //1플레이어 방어시
            if (bonus2[room] == true) {
              rand2[room] -= 2;
              bonus2[room] = undefined;
            }
            if (rand2[room] == -8) {
              result1 += "🎯관통됨!🎯\n";
              rand[room] = 0;
            } else if (rand[room] + rand2[room] > 0) 
              result1 += "🌀회피!🌀\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "🔗공격받음!🔗\n";
            else 
              result1 += "🛡막아냄!🛡\n";
            hpsum += HP1[room] + " => ";
            HP1[room] = HP1[room] + rand[room] + rand2[room];
            hpsum += HP1[room];
            result1 += player2[room] + " : ";
            if (rand2[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand2[room] + rand[room] > 0) 
              result1 += "🔀빗나감!🔀\n";
            else if (rand[room] + rand2[room] == -7 || rand[room] + rand2[room] == -6) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] + rand2[room] == 0) 
              result1 += "🔄공격이 막힘!🔃\n";
            hpsum += "\n" + player2[room] + "님의 HP : ";
            hpsum += HP2[room] + " => " + HP2[room];
          } else {
            //1플레이어 공격시
            if (bonus1[room] == true) {
              rand[room] -= 2;
              bonus1[room] = undefined;
            }
            if (bonus2[room] == true) {
              rand2[room] -= 2;
              bonus2[room] = undefined;
            }
            if (rand[room] > rand2[room]) 
              result1 += "🔗공격받음!🔗\n";
            else if (rand[room] != rand2[room] && rand[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] < rand2[room] && (rand[room] == -7 || rand[room] == -6)) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] < rand2[room]) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] == rand2[room]) 
              result1 += "💥충돌!💥\n";
            result1 += player2[room] + " : ";
            //player 2
            if (rand[room] < rand2[room]) 
              result1 += "🔗공격받음!🔗\n";
            else if (rand[room] != rand2[room] && rand2[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] > rand2[room] && (rand2[room] == -7 || rand2[room] == -6)) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] > rand2[room]) 
              result1 += "⚔공격함!⚔\n";
            else if (rand[room] == rand[room]) 
              result1 += "💥충돌!💥\n";
            if (rand[room] < rand2[room]) 
              hpsum += HP1[room] + " => " + HP1[room];
            else if (rand[room] > rand2[room]) {
              hpsum += HP1[room] + " => ";
              HP1[room] += rand2[room];
              hpsum += HP1[room];
            } else if (rand[room] == rand2[room]) 
              hpsum += HP1[room] + " => " + HP1[room];
            hpsum += "\n" + player2[room] + "님의 HP : ";
            if (rand[room] > rand2[room]) 
              hpsum += HP2[room] + " => " + HP2[room];
            else if (rand[room] < rand2[room]) {
              hpsum += HP2[room] + " => ";
              HP2[room] += rand[room];
              hpsum += HP2[room];
            } else if (rand[room] == rand2[room]) 
              hpsum += HP2[room] + " => " + HP2[room];
          }
          data[room] = 1;
          if (HP1[room] > 0 && HP2[room] > 0 && turn[room] != maxturn) 
            hpsum += "\n선공 : " + player1[room] + "님입니다!";
          replier.reply("{ " + turn[room] + "번째 턴 결과 }\n" + player1[room] + " : " + sum3 + "\n" + player2[room] + " : " + sum.replace("{{공격 주사위 결과}}\n", "") + "\n" + result1 + hpsum);
          whowin_bot(room, replier);
        } else {
          delay(1000);
          replier.reply(player2[room] + " : %방어");
          data[room] = 5;
          replier.reply("또르륵...");
          rand2[room] = random(1, 7);
          var sum = "{{방어 주사위 결과}}\n";
          delay(2000);
          bonus2[room] = true;
          if (rand2[room] == 1) {
            sum += "⚀";
          } else if (rand2[room] == 2) {
            sum += "⚁";
          } else if (rand2[room] == 3) {
            sum += "⚂";
          } else if (rand2[room] == 4) {
            sum += "⚃";
          } else if (rand2[room] == 5) {
            sum += "⚄";
          } else if (rand2[room] == 6) {
            sum += "⚅";
          }
          data[room] = 1;
          var sum3;
          if (rand[room] == -1 || rand[room] == 1) {
            sum3 = "⚀";
          } else if (rand[room] == -2 || rand[room] == 2) {
            sum3 = "⚁";
          } else if (rand[room] == -3 || rand[room] == 3) {
            sum3 = "⚂";
          } else if (rand[room] == -4 || rand[room] == 4) {
            sum3 = "⚃";
          } else if (rand[room] == -5 || rand[room] == 5) {
            sum3 = "⚄";
          } else if (rand[room] == -6 || rand[room] == 6) {
            sum3 = "⚅";
          }
          if (bonus1[room] == true && rand[room] < 0) 
            sum3 += " + ⚁!";
          var result1 = "\xa3 합산 \xa3\n" + player1[room] + " : ";
          var hpsum = "\n" + player1[room] + "님의 HP : ";
          if (rand[room] > 0) {
            //1플레이어 방어시
            result1 += "⛔대치!⛔\n" + player2[room] + " : ⛔대치!⛔\n";
            hpsum += HP1[room] + " => ";
            HP1[room] += rand[room];
            hpsum += HP1[room];
            hpsum += "\n" + player2[room] + "님의 HP : " + HP2[room] + " => ";
            HP2[room] += rand2[room];
            hpsum += HP2[room];
          } else {
            //1플레이어 공격시
            if (bonus1[room] == true) {
              rand[room] -= 2;
              bonus1[room] = undefined;
            }
            if (rand[room] + rand2[room] == 0) 
              result1 += "🔄공격이 막힘!🔃\n";
            else if (rand[room] + rand2[room] > 0) 
              result1 += "🔀빗나감!🔀\n";
            else if (rand[room] == -8) 
              result1 += "🌋파괴!🌋\n";
            else if (rand[room] + rand2[room] <= -6) 
              result1 += "🔥최대피해!🔥\n";
            else if (rand[room] + rand2[room] < 0) 
              result1 += "⚔공격함!⚔\n";
            hpsum += HP1[room] + " => " + HP1[room];
            result1 += player2[room] + " : ";
            if (rand[room] + rand2[room] > 0) 
              result1 += "🌀회피!🌀\n";
            else if (rand[room] == -8) {
              result1 += "🎯관통됨!🎯\n";
              rand2[room] = 0;
            } else if (rand[room] + rand2[room] < 0) 
              result1 += "🔰견디기!🔰\n";
            else 
              result1 += "🛡막아냄!🛡\n";
            hpsum += "\n" + player2[room] + "님의 HP : " + HP2[room] + " => ";
            HP2[room] = HP2[room] + rand[room] + rand2[room];
            hpsum += HP2[room];
          }
          if (HP1[room] > 0 && HP2[room] > 0 && turn[room] != maxturn) 
            hpsum += "\n선공 : " + player1[room] + "님입니다!";
          replier.reply("{ " + turn[room] + "번째 턴 결과 }\n" + player1[room] + " : " + sum3 + "\n" + player2[room] + " : " + sum.replace("{{방어 주사위 결과}}\n", "") + "\n" + result1 + hpsum);
          whowin_bot(room, replier);
        }
      }
    } else if (data[room] == 2) {
      if (sender == player1[room]) {
        replier.reply("당신의 차례가 아닙니다!");
      } else if (sender == player2[room]) {
        timer[room] = get_time();
        replier.reply("또르륵...");
        data[room] = 5;
        rand2[room] = random(1, 7);
        var sum = "{{방어 주사위 결과}}\n";
        delay(2000);
        bonus2[room] = true;
        if (rand2[room] == 1) {
          sum += "⚀";
        } else if (rand2[room] == 2) {
          sum += "⚁";
        } else if (rand2[room] == 3) {
          sum += "⚂";
        } else if (rand2[room] == 4) {
          sum += "⚃";
        } else if (rand2[room] == 5) {
          sum += "⚄";
        } else if (rand2[room] == 6) {
          sum += "⚅";
        }
        replier.reply(sum);
        data[room] = 1;
        var sum3;
        if (rand[room] == -1 || rand[room] == 1) {
          sum3 = "⚀";
        } else if (rand[room] == -2 || rand[room] == 2) {
          sum3 = "⚁";
        } else if (rand[room] == -3 || rand[room] == 3) {
          sum3 = "⚂";
        } else if (rand[room] == -4 || rand[room] == 4) {
          sum3 = "⚃";
        } else if (rand[room] == -5 || rand[room] == 5) {
          sum3 = "⚄";
        } else if (rand[room] == -6 || rand[room] == 6) {
          sum3 = "⚅";
        }
        if (bonus1[room] == true && rand[room] < 0) 
          sum3 += " + ⚁!";
        var result1 = "\xa3 합산 \xa3\n" + player1[room] + " : ";
        var hpsum = "\n" + player1[room] + "님의 HP : ";
        if (rand[room] > 0) {
          //1플레이어 방어시
          result1 += "⛔대치!⛔\n" + player2[room] + " : ⛔대치!⛔\n";
          hpsum += HP1[room] + " => ";
          HP1[room] += rand[room];
          hpsum += HP1[room];
          hpsum += "\n" + player2[room] + "님의 HP : " + HP2[room] + " => ";
          HP2[room] += rand2[room];
          hpsum += HP2[room];
        } else {
          //1플레이어 공격시
          if (bonus1[room] == true) {
            rand[room] -= 2;
            bonus1[room] = undefined;
          }
          if (rand[room] + rand2[room] == 0) 
            result1 += "🔄공격이 막힘!🔃\n";
          else if (rand[room] + rand2[room] > 0) 
            result1 += "🔀빗나감!🔀\n";
          else if (rand[room] == -8) 
            result1 += "🌋파괴!🌋\n";
          else if (rand[room] + rand2[room] <= -6) 
            result1 += "🔥최대피해!🔥\n";
          else if (rand[room] + rand2[room] < 0) 
            result1 += "⚔공격함!⚔\n";
          hpsum += HP1[room] + " => " + HP1[room];
          result1 += player2[room] + " : ";
          if (rand[room] + rand2[room] > 0) 
            result1 += "🌀회피!🌀\n";
          else if (rand[room] == -8) {
            result1 += "🎯관통됨!🎯\n";
            rand2[room] = 0;
          } else if (rand[room] + rand2[room] < 0) 
            result1 += "🔰견디기!🔰\n";
          else 
            result1 += "🛡막아냄!🛡\n";
          hpsum += "\n" + player2[room] + "님의 HP : " + HP2[room] + " => ";
          HP2[room] = HP2[room] + rand[room] + rand2[room];
          hpsum += HP2[room];
        }
        if (HP1[room] > 0 && HP2[room] > 0 && turn[room] != maxturn) 
          hpsum += "\n선공 : " + player2[room] + "님입니다!";
        delay(1000);
        replier.reply("{ " + turn[room] + "번째 턴 결과 }\n" + player1[room] + " : " + sum3 + "\n" + player2[room] + " : " + sum.replace("{{방어 주사위 결과}}\n", "") + "\n" + result1 + hpsum);
        whowin(room, replier);
      }
    }
  }
}
function run(winner, loser, room) {
  let ban1, ban2;
  for (let i = 0; i < ban_nick.length; i++) {
    if (winner.includes(ban_nick[i])) {
      ban1 = true;
      break;
    }
    if (loser.includes(ban_nick[i])) {
      ban2 = true;
      break;
    }
  }
  if (!ban1 && DataBase.getDataBase(FilePath+winner + "의 전적") == undefined) 
    DataBase.setDataBase(FilePath+winner + "의 전적", "0\n0\n0\n0\n0\n0\n0\n0");
  if (!ban2 && DataBase.getDataBase(FilePath+loser + "의 전적") == undefined) 
    DataBase.setDataBase(FilePath+loser + "의 전적", "0\n0\n0\n0\n0\n0\n0\n0");
  if (mod[room] == 0) {
    if (!ban1) 
      plus(winner, 0);
    if (!ban2) 
      plus(loser, 2);
  }
}
function nowin(winner, loser, room, replier) {
  let ban1, ban2;
  for (let i = 0; i < ban_nick.length; i++) {
    if (winner.includes(ban_nick[i])) {
      ban1 = true;
      break;
    }
    if (loser.includes(ban_nick[i])) {
      ban2 = true;
      break;
    }
  }
  if (!ban1 && DataBase.getDataBase(FilePath+winner + "의 전적") == undefined) 
    DataBase.setDataBase(FilePath+winner + "의 전적", "0\n0\n0\n0\n0\n0\n0\n0");
  if (!ban2 && DataBase.getDataBase(FilePath+loser + "의 전적") == undefined) 
    DataBase.setDataBase(FilePath+loser + "의 전적", "0\n0\n0\n0\n0\n0\n0\n0");
  if (mod[room] == 0) {
    if (!ban1) 
      plus(winner, 1);
    if (!ban2) 
      plus(loser, 1);
  }
  player1[room] = undefined;
  player2[room] = undefined;
  data[room] = undefined;
  bonus1[room] = undefined;
  bonus2[room] = undefined;
  NOWIN1[room] = undefined;
  NOWIN2[room] = undefined;
}
function win(winner, loser, room, replier) {
  let ban1, ban2;
  for (let i = 0; i < ban_nick.length; i++) {
    if (winner.includes(ban_nick[i])) {
      ban1 = true;
      break;
    }
    if (loser.includes(ban_nick[i])) {
      ban2 = true;
      break;
    }
  }
  if (!ban1 && DataBase.getDataBase(FilePath+winner + "의 전적") == undefined) 
    DataBase.setDataBase(FilePath+winner + "의 전적", "0\n0\n0\n0\n0\n0\n0\n0");
  if (!ban2 && DataBase.getDataBase(FilePath+loser + "의 전적") == undefined) 
    DataBase.setDataBase(FilePath+loser + "의 전적", "0\n0\n0\n0\n0\n0\n0\n0");
  if (mod[room] == 0) {
    if (!ban1) 
      plus(winner, 0);
    if (!ban2) 
      plus(loser, 2);
  }
  replier.reply(winner + "님이 승리하셨습니다!" + (mod[room] != 0 ? "\n(모드 사용시에는 전적에 영향이 없습니다.)" : ""));
  player1[room] = undefined;
  player2[room] = undefined;
  data[room] = undefined;
  bonus1[room] = undefined;
  bonus2[room] = undefined;
  NOWIN1[room] = undefined;
  NOWIN2[room] = undefined;
  hack[room] = false;
}
function win_bot(winner, loser, room, replier) {
  if (bot.includes(winner)) {
    replier.reply(winner + "의 격파에 실패했습니다!\n(봇전에서의 패배는 기록되지 않습니다!)");
  } else {
    let ban1, ban2;
    for (let i = 0; i < ban_nick.length; i++) {
      if (winner.includes(ban_nick[i])) {
        ban1 = true;
        break;
      }
    }
    if (!ban1 && DataBase.getDataBase(FilePath+winner + "의 전적") == undefined) 
      DataBase.setDataBase(FilePath+winner + "의 전적", "0\n0\n0\n0\n0\n0\n0\n0");
    if (!ban1) 
      plus(winner, bot.indexOf(loser) + 3);
    replier.reply(winner + "님이 " + loser + "의 격파에 성공하셨습니다!");
  }
  player1[room] = undefined;
  player2[room] = undefined;
  data[room] = undefined;
  bonus1[room] = undefined;
  bonus2[room] = undefined;
  NOWIN1[room] = undefined;
  NOWIN2[room] = undefined;
}
function whowin(room, replier) {
  NOWIN1[room] = undefined;
  NOWIN2[room] = undefined;
  if (HP1[room] <= 0 || HP1[room] >= 40) {
    win(player2[room], player1[room], room, replier);
    return;
  } else if (HP2[room] <= 0 || HP2[room] >= 40) {
    win(player1[room], player2[room], room, replier);
    return;
  }
  turn[room]++;
  if (turn[room] > maxturn) {
    if (HP1[room] > HP2[room]) 
      win(player1[room], player2[room], room, replier);
    else if (HP1[room] < HP2[room]) 
      win(player2[room], player1[room], room, replier);
    else if (HP1[room] == HP2[room]) {
      nowin(player1[room], player2[room], room, replier);
      replier.reply("무승부입니다!");
    }
    return;
  }
  var tmp = player1[room];
  player1[room] = player2[room];
  player2[room] = tmp;
  tmp = HP1[room];
  HP1[room] = HP2[room];
  HP2[room] = tmp;
  tmp = bonus1[room];
  bonus1[room] = bonus2[room];
  bonus2[room] = tmp;
}
function whowin_bot(room, replier) {
  NOWIN1[room] = undefined;
  NOWIN2[room] = undefined;
  if (HP1[room] <= 0 || HP1[room] >= 40) {
    win_bot(player2[room], player1[room], room, replier);
    return;
  } else if (HP2[room] <= 0) {
    win_bot(player1[room], player2[room], room, replier);
    return;
  }
  if (HP2[room] == 1 && rand2[room] == -10) {
    win_bot(player1[room], player2[room], room, replier);
    return;
  }
  turn[room]++;
  if (turn[room] > maxturn + 10) {
    if (HP1[room] > HP2[room]) 
      win_bot(player1[room], player2[room], room, replier);
    else if (HP1[room] < HP2[room]) 
      win_bot(player2[room], player1[room], room, replier);
    else if (HP1[room] == HP2[room]) {
      replier.reply("무승부입니다! " + player2[room] + " 격파 실패!");
      player1[room] = undefined;
      player2[room] = undefined;
      data[room] = undefined;
      bonus1[room] = undefined;
      bonus2[room] = undefined;
      NOWIN1[room] = undefined;
      NOWIN2[room] = undefined;
    }
    return;
  }
}
function plus(sender, index) {
  let text = DataBase.getDataBase(FilePath+sender + "의 전적").split("\n");
  if (text[index] == undefined) 
    text[index] = 0;
  text[index] = Number(text[index]) + 1;
  let s = "";
  for (let i = 0; i < text.length - 1; i++) 
    s += text[i] + "\n";
  s += text[text.length - 1];
  DataBase.setDataBase(FilePath+sender + "의 전적", s);
}
function getRound(value, digit) {
  return Number(Math.round(value + 'e' + digit) + 'e-' + digit);
}
function show_R(member, replier) {
  replier.reply("📋전적📋\n닉네임 : " + member + "\n승리 : " + DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[0] + "번\n무승부 : " + DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[1] + "번\n패배 : " + DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[2] + "번\n승률 : " + calculate(Number(DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[0]), Number(DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[2])) + "%\n" + bot[0] + "을(를) " + DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[3] + "회 격파함\n" + bot[1] + "을(를) " + DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[4] + "회 격파함\n" + bot[2] + "을(를) " + DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[5] + "회 격파함\n" + bot[3] + "을(를) " + DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[6] + "회 격파함\n" + bot[4] + "을(를) " + DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[7] + "회 격파함\n" + bot[5] + "을(를) " + (DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[8] == undefined ? 0 : DataBase.getDataBase(FilePath+member + "의 전적").split("\n")[8]) + "회 격파함");
}
function calculate(win, lose) {
  if (win == 0) 
    return 0;
  return getRound(Number(win) / (Number(win) + Number(lose)) * 100, 2);
}
function set(sender, index, sum) {
  if (DataBase.getDataBase(FilePath+sender + "님의 정보") == undefined) 
    return;
  let text = DataBase.getDataBase(FilePath+sender + "님의 정보").split("\n");
  text[index] = sum;
  let s = "";
  for (let i = 0; i < text.length - 1; i++) 
    s += text[i] + "\n";
  s += text[text.length - 1];
  DataBase.setDataBase(FilePath+sender + "님의 정보", s);
}
function get_time() {
  let date = new Date();
  return Math.trunc(date.getTime() / 1000);
}
function get_image_import(imageDB) {
  return java.lang.String(imageDB.getProfileImage()).hashCode();
}
function onNotificationPosted(sbn, sm) {
    var packageName = sbn.getPackageName();
    if (!packageName.startsWith("com.kakao.tal")) return;
    var actions = sbn.getNotification().actions;
    if (actions == null) return;
    var userId = sbn.getUser().hashCode();
    for (var n = 0; n < actions.length; n++) {
        var action = actions[n];
        if (action.getRemoteInputs() == null) continue;
        var bundle = sbn.getNotification().extras;

        var msg = bundle.get("android.text").toString();
        var sender = bundle.getString("android.title");
        var room = bundle.getString("android.subText");
        if (room == null) room = bundle.getString("android.summaryText");
        var isGroupChat = room != null;
        if (room == null) room = sender;
        var replier = new com.xfl.msgbot.script.api.legacy.SessionCacheReplier(packageName, action, room, false, "");
        var icon = bundle.getParcelableArray("android.messages")[0].get("sender_person").getIcon().getBitmap();
        var image = bundle.getBundle("android.wearable.EXTENSIONS");
        if (image != null) image = image.getParcelable("background");
        var imageDB = new com.xfl.msgbot.script.api.legacy.ImageDB(icon, image);
        com.xfl.msgbot.application.service.NotificationListener.Companion.setSession(packageName, room, action);
        if (this.hasOwnProperty("responseFix")) {
            responseFix(room, msg, sender, isGroupChat, replier, imageDB, packageName, userId != 0);
        }
    }
}
