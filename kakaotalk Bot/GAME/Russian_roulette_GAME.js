const using_room = "게임";//사용될 방이름을 입력해주세요.
/**
< 파일 형식 (숫자는 index) >
 file name : sender님의 정보
 0. 착용한 칭호
 1. 승리(일반)
 2. 패배(일반)
 3. points
 4. 마지막 플레이 시간
 [ 보안정보 ]
 5. 프로필번호
 6. 비밀번호
 7. 블랙리스트 여부
 [ 랭겜정보 ]
 8. 플레이횟수(랭크)
 9. 점수(랭크)
 10. 최고점수(랭크)
 11. 사용중인 칭호방식(1 : 뽑은 칭호, 2 : 티어 칭호)
 */
function delay(time) {
  java.lang.Thread.sleep(time);
}
function random(small, big) {
  return Math.floor(Math.random() * (big - small)) + small;
}
/**
[ 관리자용 명령어 도움말 ]
※모든 관리자용 명령어는 디버깅룸 내의 패키지명을 op 으로 설정하셔야만 사용가능합니다.
패키지명 변경 관련 정보는 제 유튜브를 참고해주세요.


※추가적으로 유저의 포인트 수를 조절하고 전적을 수정하는 등의 기능 또한 추가가 가능하였으나, 악용의 우려에 의해 추가하지 않으려 했습니다.
하지만, 이는 봇 관리자의 권한을 낮추기때문에 직접적으로 유저의 정보을 수정할수 있는 기능을 추가하도록 했습니다.(eval 명령어 참고)

[ %ban (밴 대상의 닉네임) ]
- 대상을 밴합니다. 밴된 대상은 게임에 참여하지 못하고 명령어를 사용하지 못합니다.

[ %unban (밴 대상의 닉네임) ]
- 대상의 밴을 해제합니다.

[ %비밀번호 (비밀번호) ]
- 현재 자신이 설정한 디버깅룸 내의 닉네임의 유저의 비밀번호를 변경합니다.

[ %보안정보 ]
- 현재 자신이 설정한 디버깅룸 내의 닉네임의 유저의 비밀번호를 확인합니다.

[ %title (칭호) ]
- 현재 자신이 설정한 디버깅룸 내의 닉네임의 유저의 칭호를 설정합니다.

[ %eval set( "(설정할 유저의 닉네임)" or sender(디버깅룸 내의 본인의 닉네임) , index(위의 파일 형식 참고) , sum(수정할 값) ) ]
- 오류가 쉽게 날수 있는 위험한 명령어입니다.
- eval을 이용하였기에 제가 추가해둔 몇몇 함수를 직접적으로 사용하실수 있습니다.
(ex. %eval plus(sender, 2) : 일반 게임의 패배수에 1더하기 )
- 사용 난이도가 좀 있기때문에 아래의 도움말을 꼼꼼히 읽어보시고 이해한뒤 사용해주세요.

[ 사용가능 함수 ]
⚠️set("플레이어 이름", index, sum) : index를 sum값으로 설정함
⚠️plus("플레이어 이름", index) : index에 1을 더함. 숫자로 바꿀수 없는곳에 해당 함수를 쓰면 NaN으로 전환될수 있음
get_time() : 현재 시간을 가져옴
get_import("플레이어 이름", index) : index의 값을 가져옴.
get_title("플레이어 이름") : 해당 유저의 칭호를 가져옴.
※디버깅룸 내의 닉넴이 플레이어 이름과 같다면 "플레이어 이름" 대신 sender 을 사용해도 됩니다.
*/
const gameTimer = 15;
const roomTimer = 50;
const helpmeesage = "%도움말";
const joinmessage = "%참여";
const startmessage = "%시작";
const finishmessage = "%퇴장";
const roommessage = "%방정보";
const entrymessage = "%가입";
const normalmessage = "%일반";
const rankmessage = "%랭크";
const kickmessage = "%강퇴";
const loginmessage = "%로그인";
const passwordmessage = "%비밀번호";
const secretmessage = "%보안정보";
const titlemessage = "%칭호";
const normal_title_message = "%일반칭호";
const good_title_message = "%고급칭호";
const vip_title_message = "%최고급칭호";
const season_title_message = "%계절칭호";
const special_title_message = "%특별칭호";
const get_import_message = "%정보";
const fire_message = "%발사";
const title_set_message = "%칭호변경";
const repair_message = "%계정복구";
const maxplayer = 10;//최대 유저수
const bullet = 6;//약실 수
const tier = ["랭크 없음", "🥉브론즈3", "🥉브론즈2", "🥉브론즈1", "🥈실버4", "🥈실버3", "🥈실버2", "🥈실버1", "🥇골드4", "🥇골드3", "🥇골드2", "🥇골드1", "🔰플래티넘3", "🔰플래티넘2", "🔰플래티넘1", "💠다이아3", "💠다이아2", "💠다이아1", "⚜Master3", "⚜Master2", "⚜Master1", "🏆Champion3", "🏆Champion2", "🏆Champion1", "👑King2", "👑King1", "🔮Legend2🔮", "🔮Legend1🔮"];
const tier_score = [0, 1, 20, 40, 80, 100, 120, 140, 200, 230, 260, 300, 350, 400, 450, 600, 700, 800, 1000, 1300, 1600, 2000, 2500, 3000, 4000, 5000, 8000, 10000];
const standard_title = ["<초보>", "<중수>", "<고수>", "<귀여미>", "<바브>"];//원하시는 칭호를 추가&변경하세요!
const season_title = ["🌼SPRING🌼", "☀️SUMMER☀️", "🍁AUTUMN🍁", "❄WINTER❄"];
const normal_title = ["\xa4 고인물 \xa4", "& 썩은물 &", "◇실력자◇"];
const vip_title = ["🌠STAR🌠", "🍕PIZZA🍕", "🍗CHICKEN🍗", "탕!(총)", "💣BOOM!💣", "🌄일출🌄", "🌅일몰🌅", "🌌은하수🌌", "🌃고요한 밤🌃", "👑게임의 지배자👑", "🌟세계최강🌟 ⚜귀요미⚜", "🧭나만의 길🧭", "⏳영원한 시간⏳", "🌉다시 떠오르는 별🌉", "🌊몰아치는 파도🌊"];
const ban_nick = ["/", "<", ">", "*", "?", ":", "\"", "\n", "|"];
var isplaying = false;
var joining_players = 0;
var persons = 0;
var player = [];
var fire;
var where;
var mod;
var timer;
var kick = [];
var Runnable = java.lang.Runnable;
var Thread = java.lang.Thread;
function responseFix(room, msg, sender, isGroupChat, replier, imageDB, packageName) {
  if (!isGroupChat) {
    if (msg == secretmessage) {
      if (is_real(sender, get_image_import(imageDB)) == false && packageName != "op") {
        replier.reply("접근권한이 없습니다.");
        return;
      }
      if (get_title(sender) == undefined) {
        replier.reply("존재하지 않는 유저입니다.");
        return;
      }
      replier.reply("🆔️ : " + sender + "\n🔑 : " + get_import(sender, 6));
    } else if (msg.split(" ")[0] == loginmessage && get_title(sender) != undefined) {
      if (msg.split(" ")[1] == DataBase.getDataBase(sender + "님의 정보").split("\n")[6]) {
        replier.reply("로그인 성공!");
        set(sender, 5, java.lang.String(imageDB.getProfileImage()).hashCode());
      } else 
        replier.reply("비밀번호가 틀렸습니다.");
    } else if (msg.split(" ")[0] == passwordmessage) {
      if (!is_real(sender, get_image_import(imageDB)) && packageName != "op") 
        return;
      if (!get_title(sender)) {
        replier.reply("존재하지 않는 유저입니다.");
        return;
      }
      if (msg.split(" ").length > 2 || msg.split(" ")[1] == undefined) {
        replier.reply(passwordmessage + " (비밀번호) 형식으로 입력해주세요! 비밀번호에는 띄어쓰기가 있으면 안됩니다!");
        return;
      }
      if (msg.split(" ")[1].length > 10) {
        replier.reply("10자 이하로 설정해주세요!");
        return;
      }
      if (msg.split(" ")[2] != undefined) {
        replier.reply("비밀번호에는 띄어쓰기를 사용할수 없습니다!");
        return;
      }
      if (msg.split(" ")[1].includes("\n")) {
        replier.reply("줄바꿈문자를 비밀번호에 사용할수 없습니다!");
        return;
      }
      if (msg.split(" ")[1].length < 2) {
        replier.reply("비밀번호가 너무 짧아요!");
        return;
      }
      replier.reply(msg.split(" ")[1] + "으로 설정되었습니다.");
      set(sender, 6, msg.split(" ")[1]);
    } else if (msg.split("\n")[0] == repair_message) {
      if (get_title(sender) != undefined) {
        replier.reply("현재 " + sender + "님의 닉네임으로 계정이 이미 생성되었습니다. 다른 닉네임으로 시도해주세요!");
        return;
      }
      if (msg.split("\n").length != 3) {
        replier.reply(repair_message + "\n(이전 닉네임)\n(이전 비밀번호)\n형식으로 입력해주세요.");
        return;
      }
      if (get_title(msg.split("\n")[1]) == undefined) {
        replier.reply("해당 닉네임은 존재하지 않습니다.");
        return;
      }
      if (msg.split("\n")[2] != get_import(msg.split("\n")[1], 6)) {
        replier.reply("비밀번호가 틀렸습니다.");
        return;
      }
      for (let i = 0; i < ban_nick.length; i++) {
        if (sender.includes(ban_nick[i])) {
          replier.reply("닉네임에 사용이 불가능한 문자인 [ " + ban_nick[ì] + " ] 이 있습니다.");
          return;
        }
      }
      DataBase.setDataBase(sender + "님의 정보", DataBase.getDataBase(msg.split("\n")[1] + "님의 정보"));
      DataBase.removeDataBase(msg.split("\n")[1] + "님의 정보");
      set(sender, 5, get_image_import(imageDB));
      replier.reply("계정 이전에 성공하셨습니다. 전 계정은 삭제처리되며, 이는 복구가 불가능할수 있습니다.");
    } else if (msg == "%이스터에그" && get_title(sender) == "<가입자>") 
      set(sender, 0, "☸숨겨진것을 찾은자☸");
    if (packageName == "op") 
      replier.reply("현재 디버깅룸이 갠쳇 상태입니다. 디버깅룸을 단체 채팅방 상태로 설정하셔야 관리자용 명령어를 사용할수 있습니다.(해당 메시지는 패키지명이 op이고 갠쳇 상태일때만 표시됩니다.)");
    return;
  }
  if (room != using_room && packageName != "op") 
    return;
  if (msg == joinmessage) {
    if (is_black(sender) == true) {
      return;
    }
    if (isplaying == true) {
      replier.reply("이미 게임이 시작되었습니다. 게임이 끝나고 다시 시도해주세요!");
      return;
    }
    if (is_real(sender, get_image_import(imageDB)) == false) {
      replier.reply("로그인이 되어있지 않습니다. " + entrymessage + " 명령어를 쳐주시거나 가입하셨는데 해당 메시지가 뜨면 " + loginmessage + " (비번) 을 쳐주세요!");
      return;
    }
    if (kick.includes(sender) && joining_players != 0) {
      replier.reply("이번 방에서 강퇴당했습니다. 다음판부터 참여가 가능합니다.");
      return;
    }
    if (kick.includes(sender) && joining_players == 0) {
      replier.reply("이전 방이 일정 시간내에 시작하지 않아 해체되어서 방을 생성하실수 없습니다.(참여는 가능합니다.)");
      return;
    }
    if (player.includes(sender)) {
      replier.reply("[ 이미 참여하셨습니다! ]");
      return;
    }
    if (!player[1]) {
      mod = 0;
      joining_players = 0;
      joining_players++;
      player[joining_players] = sender;
      replier.reply("[ " + get_title(sender) + " " + sender + " ]님이 방을 생성하셨습니다.\n참가는 \"" + joinmessage + "\" 입니다.\n현재 게임모드 : 일반게임");
      kick[0] = undefined;
      timer = 0;
      new Thread(new Runnable() {
  run: function() {
  while (roomTimer * 10 != timer) {
    delay(102);
    timer++;
    if (isplaying) 
      break;
    if (!player[1]) 
      break;
    if (timer == roomTimer * 10 - 100) 
      replier.reply("10초 내에 시작하지 않으면 방이 해체되며, 다음 방을 생성할수 없게됩니다.");
    else if (timer == roomTimer * 10) {
      replier.reply("방을 생성한지 " + roomTimer + "초가 지나도록 게임을 시작하지 않아서 방이 해체됩니다.");
      reset();
      kick[0] = sender;
      break;
    }
  }
}}).start();
    } else {
      joining_players++;
      player[joining_players] = sender;
      replier.reply("[ " + get_title(sender) + " " + sender + " ]님이 방에 참가하셨습니다.\n참가는 \"" + joinmessage + "\" 입니다.\n" + getjoining() + "\n현재 게임모드 : " + (mod == 0 ? "일반게임" : "랭크게임"));
    }
    if (joining_players == maxplayer) {
      setting();
      replier.reply("방이 꽉차서 자동으로 게임을 시작합니다..\n[ + " + fire_message + " ] 으로 자신의 차례에 방아쇠를 당깁니다.\n[ " + player[1] + " ]님의 차례입니다.");
    }
  } else if (msg == entrymessage) {
    if (is_real(sender, get_image_import(imageDB)) == true) {
      replier.reply("이미 가입하셨습니다!");
      return;
    }
    if (DataBase.getDataBase(sender + "님의 정보") != undefined) {
      replier.reply("이미 가입된적이 있는 닉네임입니다. 닉네임을 바꿔서 재시도해주세요! (※오픈프로필이신 경우, 닉넴을 바꿔도 즉시 적용되지 않을수 있습니다. 그럴때는 봇 주인을 불러보세요!)");
      return;
    }
    for (let i = 0; i < ban_nick.length; i++) {
      if (sender.includes(ban_nick[i])) {
        replier.reply("닉네임에 사용이 불가능한 문자인 [ " + ban_nick[i] + " ] 이 있습니다.");
        return;
      }
    }
    replier.reply("러시안룰렛에 가입해주셔서 감사합니다 :D\n명령어는 [ " + helpmeesage + " ] 를 입력해주세요!");
    join(sender, get_image_import(imageDB));
  } else if (msg.split("\n")[0] == repair_message) {
    if (get_title(sender) != undefined) {
      replier.reply("현재 " + sender + "님의 닉네임으로 계정이 이미 생성되었습니다. 다른 닉네임으로 시도해주세요!");
      return;
    }
    if (msg.split("\n").length != 3) {
      replier.reply(repair_message + "\n(이전 닉네임)\n(이전 비밀번호)\n형식으로 입력해주세요.");
      return;
    }
    if (get_title(msg.split("\n")[1]) == undefined) {
      replier.reply("해당 닉네임은 존재하지 않습니다.");
      return;
    }
    if (msg.split("\n")[2] != get_import(msg.split("\n")[1], 6)) {
      replier.reply("비밀번호가 틀렸습니다.");
      return;
    }
    DataBase.setDataBase(sender + "님의 정보", DataBase.getDataBase(msg.split("\n")[1] + "님의 정보"));
    DataBase.removeDataBase(msg.split("\n")[1] + "님의 정보");
    set(sender, 5, get_image_import(imageDB));
    replier.reply("계정 이전에 성공하셨습니다. 전 계정은 삭제처리되며, 이는 복구가 불가능할수 있습니다.");
  }
  if (is_real(sender, get_image_import(imageDB)) == false && packageName != "op") 
    return;
  if (msg == finishmessage) {
    if (!player.includes(sender)) 
      return;
    if (isplaying == false) {
      if (sender == player[1]) {
        if (joining_players == 1) {
          replier.reply("참가한 인원이 없어 방이 사라집니다!");
          reset();
          return;
        }
        for (let i = 2; i < joining_players + 2; i++) {
          player[i - 1] = player[i];
        }
        joining_players--;
        replier.reply("방장이 나가서 " + player[1] + "님이 방장이 됩니다.\n현재 인원 : " + getjoining(replier));
      } else {
        let b = player.indexOf(sender);
        for (let i = player.indexOf(sender) + 1; i <= joining_players; i++) {
          player[i - 1] = player[i];
        }
        player[joining_players] = undefined;
        joining_players--;
        replier.reply("성공적으로 나가셨습니다!\n현재 인원 : " + getjoining(replier));
      }
    } else {
      replier.reply("기권했습니다.");
      timer = 0;
      out(sender, replier);
    }
  } else if (msg.split(" ")[0] == kickmessage && sender == player[1]) {
    let kick_name = msg.split(" ")[1];
    if (isNaN(kick_name)) {
      replier.reply(kickmessage + " (강퇴할 유저의 번호) 형식으로 입력해주세요.(ex. " + kickmessage + " 3)");
      return;
    }
    kick_name = Math.trunc(Number(kick_name));
    if (kick_name == 1) {
      replier.reply("본인을 강퇴하시려는건가요..?");
      return;
    }
    if (player[kick_name] == undefined) {
      replier.reply(kick_name + "번째 유저가 없어요!");
      return;
    }
    kick.push(player[kick_name]);
    let b = kick_name;
    for (let i = kick_name + 1; i <= joining_players; i++) {
      player[i - 1] = player[i];
    }
    player[joining_players] = undefined;
    joining_players--;
    replier.reply("성공적으로 강퇴했습니다.\n현재 인원 : " + getjoining(replier));
  } else if (msg == roommessage) {
    if (joining_players == 0) {
      replier.reply("아무도 참가해있지 않아요..");
      return;
    }
    replier.reply("현재 방에 참가해있는 유저 정보입니다.\n" + getjoining());
  } else if (msg == startmessage && sender == player[1]) {
    if (joining_players < 2) {
      replier.reply("2명 이상의 유저가 방에 참가했을때 시작이 가능합니다!");
      return;
    }
    setting();
    replier.reply("게임을 시작합니다..\n[ " + fire_message + " ] 명령어로 자신의 차례에 방아쇠를 당기세요!\n[ " + player[1] + " ]님의 차례입니다.");
    new Thread(new Runnable() {
  run: function() {
  while (isplaying) {
    while (gameTimer * 10 != timer) {
      delay(102);
      timer++;
      if (!isplaying) 
        break;
      if (timer == gameTimer * 10 - 50) 
        replier.reply("5초 남았습니다.");
    }
    if (isplaying) {
      replier.reply("시간 경과로 인해 [ " + player[turn] + " ] 님이 탈락합니다!");
      out(player[turn], replier);
      timer = 0;
    }
  }
}}).start();
  } else if (msg == rankmessage && isplaying == false) {
    if (sender != player[1]) {
      replier.reply("게임 모드는 방장만 설정이 가능합니다!");
      return;
    }
    mod = 1;
    replier.reply("[ 🏅 ] 게임모드가 랭크게임으로 설정되었습니다.");
  } else if (msg == normalmessage && isplaying == false) {
    if (sender != player[1]) {
      replier.reply("게임 모드는 방장만 설정이 가능합니다!");
      return;
    }
    mod = 0;
    replier.reply("[ (총) ] 게임모드가 일반게임으로 설정되었습니다.");
  } else if (msg == titlemessage && !player.includes(sender)) {
    replier.reply("[ 칭호 상품 목록 ]\n\n\n일반 칭호상자 (가격 : 3point) : " + normal_title_message + "\n고급 칭호상자 (가격 : 6point) : " + good_title_message + "\n최고급 칭호상자 (가격 : 15point) : " + vip_title_message + "\n계절 칭호상자 (가격 : 30point) : " + season_title_message + "\n현재 획득 가능 칭호 : " + get_season_title() + "\n특별 칭호상자 (가격 : 50point) : " + special_title_message + "\n오늘 획득 가능한 특별 칭호 : " + get_special_day_title() + "\n※칭호를 구매하시면 이전 칭호는 사라집니다!");
  } else if (msg == get_import_message && !player.includes(sender) && is_real(sender, get_image_import(imageDB))) {
    replier.reply(show_total(sender));
  } else if (msg == fire_message && player.includes(sender) && isplaying == true) {
    if (sender != player[turn]) {
      replier.reply("[ " + sender + " ] 님의 차례가 아닙니다!");
      return;
    }
    timer = 0;
    if (fire != where) {
      turn++;
      if (turn > joining_players) 
        turn = 1;
      replier.reply("[ " + where + " 번째 약실 ]\n철컥.\n[ " + player[turn] + " ] 님의 차례입니다.");
      where++;
    } else {
      out(sender, replier);
    }
  } else if (msg.split(" ")[0] == passwordmessage) {
    replier.reply("비밀번호는 갠쳇에서만 설정할수 있습니다.");
    return;
  } else if (msg == title_set_message && !player.includes(sender)) {
    if (get_import(sender, 11) == "1") 
      set(sender, 11, 2);
    else 
      set(sender, 11, 1);
    replier.reply("[ " + get_title(sender) + " ] 으로 변경되었습니다!");
  } else if (msg == normal_title_message && !player.includes(sender)) {
    if (Number(get_import(sender, 3)) < 3) {
      replier.reply("포인트가 부족해요! 포인트는 일반게임에서 승리하면 획득이 가능하답니다!");
      return;
    }
    let i = random(0, standard_title.length);
    set(sender, 3, Number(get_import(sender, 3)) - 3);
    set(sender, 0, standard_title[i]);
    replier.reply("[ " + standard_title[i] + " ] 칭호를 뽑았습니다!");
  } else if (msg == good_title_message && !player.includes(sender)) {
    if (Number(get_import(sender, 3)) < 6) {
      replier.reply("포인트가 부족해요! 포인트는 일반게임에서 승리하면 획득이 가능하답니다!");
      return;
    }
    let i = random(0, normal_title.length);
    set(sender, 3, Number(get_import(sender, 3)) - 6);
    set(sender, 0, normal_title[i]);
    replier.reply("[ " + normal_title[i] + " ] 칭호를 뽑았습니다!");
  } else if (msg == vip_title_message && !player.includes(sender)) {
    if (Number(get_import(sender, 3)) < 15) {
      replier.reply("포인트가 부족해요! 포인트는 일반게임에서 승리하면 획득이 가능하답니다!");
      return;
    }
    let i = random(0, vip_title.length);
    set(sender, 3, Number(get_import(sender, 3)) - 15);
    set(sender, 0, vip_title[i]);
    replier.reply("[ " + vip_title[i] + " ] 칭호를 뽑았습니다!");
  } else if (msg == helpmeesage) {
    replier.reply("[ 러시안룰렛 도움말 ]" + get_all_see() + "\n\n\n[ 게임 플레이 ]\n\n[ " + joinmessage + " ]\n-게임에 참여합니다.\n\n[ " + startmessage + " ]\n-방에 2명 이상이 있을때 게임을 시작합니다.\n\n[ " + fire_message + " ]\n-방아쇠를 당깁니다.\n\n[ " + rankmessage + " ]\n-게임 모드를 랭크모드로 전환합니다. 랭크모드는 일반 게임과 진행은 똑같지만 순위와 참여 인원수에 따라 얻는 점수가 달라집니다.\n\n[ " + normalmessage + " ]\n-게임모드를 일반 게임으로 전환합니다. 일반게임에서 1등만 칭호를 살때 필요한 포인트를 획득합니다. 포인트는 참여 유저수가 많을수록 더 많이 얻을수 있습니다.\n\n[ " + finishmessage + " ]\n-방에서 퇴장합니다. 진행중일때는 사망처리가 됩니다.\n\n[ " + roommessage + " ]\n-현재 방정보(참여자)를 확인합니다.\n\n[ " + kickmessage + " (강퇴할 유저의 번호) ]\n-해당 유저를 강퇴하고 이번방에 참여하지 못하도록 합니다.\n\n\n[ 기타 명령어들 ]\n\n[ " + titlemessage + " ]\n-칭호 목록과 가격, 명령어들을 확인합니다.\n\n[ " + get_import_message + " ]\n-자신의 정보(전적, 티어 등)를 확인합니다.\n\n[ " + title_set_message + " ]\n-칭호를 티어로 표시할지, 뽑은 칭호로 표시할지 설정합니다.\n\n\n[ 계정 관련 명령어 ]\n\n[ " + loginmessage + " (개인 비밀번호) ]\n-로그인을 합니다. 가입후에 이용이 가능하며, 프사를 바꾸고 나서는 로그인을 해야합니다.\n\n[ " + secretmessage + " ]\n-비밀번호를 확인합니다.\n\n[ " + passwordmessage + " (설정할 비밀번호) ]\n-비밀번호를 변경합니다.\n\n[ 계정 복구 ]\n" + repair_message + "\n(전 닉네임)\n(전 비밀번호)\n\n※계정 복구 이후에는 전 계정이 삭제처리되며, 복구할수 없을수 있습니다.\n해당 닉네임으로 가입한적이 있다면, 해당 닉네임으로 복구가 불가능합니다.\n전 비밀번호를 모르겠다면, 봇 관리자에게 문의하세요.");
  } else if (msg == season_title_message && !player.includes(sender)) {
    if (Number(get_import(sender, 3)) < 30) {
      replier.reply("포인트가 부족해요! 포인트는 일반게임에서 승리하면 획득이 가능하답니다!");
      return;
    }
    set(sender, 3, Number(get_import(sender, 3)) - 30);
    set(sender, 0, get_season_title());
    replier.reply("[ " + get_season_title() + " ] 칭호를 획득했습니다!");
  } else if (msg == special_title_message && !player.includes(sender)) {
    if (Number(get_import(sender, 3)) < 50) {
      replier.reply("포인트가 부족해요! 포인트는 일반게임에서 승리하면 획득이 가능하답니다!");
      return;
    }
    if (get_special_day_title() == "없음") {
      replier.reply("오늘 획득 가능한 특별 칭호가 없어요!");
      return;
    }
    set(sender, 3, Number(get_import(sender, 3)) - 50);
    set(sender, 0, get_special_day_title());
    replier.reply("[ " + get_special_day_title() + " ] 칭호를 획득했습니다!");
  } else if (msg.split(" ")[0] == "%ban" && packageName == "op") {
    let n = msg.replace("%ban ", "");
    if (get_title(n) == undefined) {
      replier.reply("해당 유저는 없습니다.");
      return;
    }
    set(n, 7, true);
    replier.reply("ban success");
  } else if (msg.split(" ")[0] == "%unban" && packageName == "op") {
    let n = msg.replace("%unban ", "");
    if (get_title(n) == undefined) {
      replier.reply("해당 유저는 없습니다.");
      return;
    }
    set(n, 7, false);
    replier.reply("unban success");
  } else if (msg.split(" ")[0] == "%title" && packageName == "op") {
    let n = msg.replace("%title ", "");
    if (get_title(sender) == undefined) {
      replier.reply("해당 유저는 없습니다.");
      return;
    }
    set(sender, 0, n);
    replier.reply("title setting success");
  } else if (msg.split(" ")[0] == "%eval" && packageName == "op") {
    let n = msg.replace("%eval ", "");
    replier.reply(eval(n));
  } else if (msg == "%티어") {
    let text = "";
    for (let i = 0; i < tier.length; i++) {
      text += "\n\n" + tier[i] + "\n필요 점수 : " + tier_score[i] + "점";
    }
    replier.reply("티어 관련 정보입니다." + get_all_see() + text);
  }
}
function getjoining() {
  let text = "\n\xa4 : " + player[1];
  for (let i = 2; i <= joining_players; i++) {
    text += "\n●" + player[i];
  }
  return text;
}
function setting() {
  fire = random(1, bullet + 1);
  isplaying = true;
  where = 1;
  turn = 1;
  persons = joining_players;
  timer = 0;
}
function get_title(sender) {
  if (DataBase.getDataBase(sender + "님의 정보") == undefined) 
    return undefined;
  if (get_import(sender, 11) == "1") 
    return DataBase.getDataBase(sender + "님의 정보").split("\n")[0];
  else 
    return get_tier(get_import(sender, 9));
}
function get_image_import(imageDB) {
  return java.lang.String(imageDB.getProfileImage()).hashCode();
}
function is_real(sender, image) {
  if (DataBase.getDataBase(sender + "님의 정보") == undefined) 
    return false;
  if (DataBase.getDataBase(sender + "님의 정보").split("\n")[5] == String(image)) 
    return true;
  else 
    return false;
}
function is_black(sender) {
  if (DataBase.getDataBase(sender + "님의 정보") == undefined) 
    return false;
  if (DataBase.getDataBase(sender + "님의 정보").split("\n")[7] == "true") 
    return true;
  else 
    return false;
}
function join(sender, image) {
  DataBase.setDataBase(sender + "님의 정보", "<가입자>\n0\n0\n0\n기록 없음\n" + image + "\n" + random(1000, 9999) + "\nfalse\n0\n0\n0\n1");
}
function getRound(value, digit) {
  return Number(Math.round(value + 'e' + digit) + 'e-' + digit);
}
function calculate(win, lose) {
  if (win == 0) 
    return 0;
  return getRound(Number(win) / (Number(win) + Number(lose)) * 100, 2);
}
function show_total(sender) {
  //전적
  let text = "";
  text += get_title(sender) + "\n" + sender + "님의 정보입니다.​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​\n\n\n소유 point : " + get_import(sender, 3) + "개\n\n\n[ 일반게임 ]\n";
  text += "생존 : " + DataBase.getDataBase(sender + "님의 정보").split("\n")[1] + "회\n";
  text += "사망 : " + DataBase.getDataBase(sender + "님의 정보").split("\n")[2] + "회\n";
  text += "생존률 : " + calculate(DataBase.getDataBase(sender + "님의 정보").split("\n")[1], DataBase.getDataBase(sender + "님의 정보").split("\n")[2]) + "%\n";
  text += "\n\n[ 🏅랭크게임🏅 ]\n";
  text += "티어 : " + get_tier(Number(DataBase.getDataBase(sender + "님의 정보").split("\n")[9])) + "\n";
  text += "플레이 : " + DataBase.getDataBase(sender + "님의 정보").split("\n")[8] + "회\n";
  text += "현재 점수 : " + DataBase.getDataBase(sender + "님의 정보").split("\n")[9] + "점\n";
  text += "최고 점수 : " + DataBase.getDataBase(sender + "님의 정보").split("\n")[10] + "점\n";
  text += "최고 티어 : " + get_tier(Number(DataBase.getDataBase(sender + "님의 정보").split("\n")[10])) + "\n";
  text += "\n마지막 플레이시간 : " + DataBase.getDataBase(sender + "님의 정보").split("\n")[4];
  return text;
}
function get_tier(point) {
  point = Number(point);
  let text = "";
  if (point == 0) 
    return tier[0];
  for (let i = 1; i < tier.length; i++) {
    if (tier_score[i] <= point) 
      text = tier[i];
  }
  return text;
}
function get_time() {
  let text = "";
  var day = new Date();
  text += day.getFullYear() + "년 " + (day.getMonth() + 1) + "월 " + day.getDate() + "일 " + day.getHours() + "시 " + day.getMinutes() + "분 ";
  return text;
}
function get_all_see() {
  //전체보기 투명글자
  return "​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​";
}
function get_special_day_title() {
  let day = new Date();
  let month = day.getMonth() + 1;
  let date = day.getDate();
  if (month == 1 && date == 1) 
    return "🌅NEW YEAR!🌅";
  if (month == 2 && date > 10 && date < 14) 
    return "🙇‍♂️설날!🙇‍♀️";
  if (month == 3 && date == 1) 
    return "🇰🇷3•1절🇰🇷";
  if (month == 5 && date == 5) 
    return "🐥Children's day🐥";
  if (month == 9 && date > 19 && date < 23) 
    return "🎉추석!🎉";
  if (month == 10 && date == 31) 
    return "🎃HALLOWEEN!🎃";
  if (month == 12 && date == 25) 
    return "🎄CHRISTMAS🎄";
  if (month == 8 && date == 7) 
    return "🎂제작자 생일!🎂";
  if (month == 4 && date == 16) 
    return "🎗";
  return "없음";
}
function out(sender, replier) {
  let b = player.indexOf(sender);
  for (let i = player.indexOf(sender) + 1; i <= joining_players; i++) {
    player[i - 1] = player[i];
  }
  player[joining_players] = undefined;
  if (mod == 1) 
    rank(sender, replier);
  else 
    lose(sender, replier);
  joining_players--;
  if (player[turn] == undefined) 
    turn = 1;
  if (joining_players != 1) {
    replier.reply("방안에 총성이 울려퍼집니다.\n[ " + sender + " ] 님이 사망했습니다.\n[ " + player[turn] + " ] 님의 차례입니다.");
    fire = random(1, bullet + 1);
    isplaying = true;
    where = 1;
  } else {
    replier.reply("마지막 총성과 함께 [ " + player[1] + " ] 님이 승리했습니다!");
    isplaying = false;
    if (mod == 1) 
      rank(player[1], replier);
    else 
      win(player[1], replier);
    set(player[1], 4, get_time());
    reset();
  }
  set(sender, 4, get_time());
}
function set(sender, index, sum) {
  let text = DataBase.getDataBase(sender + "님의 정보").split("\n");
  text[index] = sum;
  let s = "";
  for (let i = 0; i < text.length - 1; i++) 
    s += text[i] + "\n";
  s += text[text.length - 1];
  DataBase.setDataBase(sender + "님의 정보", s);
}
function rank(sender, replier) {
  let score2 = DataBase.getDataBase(sender + "님의 정보").split("\n")[10];
  plus(sender, 8);
  let i = get_rank_point(sender);
  replier.reply("[ " + sender + " ] 님의 점수가 " + (i <= 0 ? (i * -1) + "점 차감됩니다." : i + "점 상승합니다."));
  if (i > 0) {
    if (get_tier(get_import(sender, 9)) != get_tier(score2)) 
      replier.reply("[ " + sender + " ] 님이 " + get_tier(get_import(sender, 9)) + "로 승급했습니다.");
  }
  if (Number(get_import(sender, 9)) > Number(get_import(sender, 10))) 
    set(sender, 10, get_import(sender, 9));
}
function get_import(sender, index) {
  return DataBase.getDataBase(sender + "님의 정보").split("\n")[index];
}
function reset() {
  joining_players = 0;
  persons = 0;
  for (let i = 0; i <= maxplayer; i++) 
    player[i] = undefined;
  for (let i = 0; i < kick.length; i++) 
    kick[i] = undefined;
}
function get_season_title() {
  let day = new Date();
  let month = day.getMonth() + 1;
  if (month >= 3 && month <= 5) 
    return season_title[0];
  else if (month >= 6 && month <= 8) 
    return season_title[1];
  else if (month >= 9 && month <= 11) 
    return season_title[2];
  else 
    return season_title[3];
}
function get_rank_point(sender) {
  let sum = 0;
  if (joining_players <= persons / 2) {
    sum = (persons / 2 - joining_players) * 6;
  } else {
    sum = (joining_players - persons / 2) * -6;
  }
  sum += 4;
  let u = Number(get_import(sender, 9));
  if (u + sum < 0) 
    u = 0;
  else 
    u += sum;
  set(sender, 9, u);
  return sum;
}

function win(sender, replier) {
  plus(sender, 1);
  let n = random(1, persons + 1);
  set(sender, 3, Number(get_import(sender, 3)) + n);
  replier.reply("[ " + sender + " ] 님이 " + n + "point 를 획득했습니다!\n현재 point : " + get_import(sender, 3));
}
function lose(sender, replier) {
  plus(sender, 2);
}
function plus(sender, index, sum) {
  let text = DataBase.getDataBase(sender + "님의 정보").split("\n");
  if (sum != undefined) 
    text[index] = Number(text[index]) + Number(sum);
  else 
    text[index] = Number(text[index]) + 1;
  let s = "";
  for (let i = 0; i < text.length - 1; i++) 
    s += text[i] + "\n";
  s += text[text.length - 1];
  DataBase.setDataBase(sender + "님의 정보", s);
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
