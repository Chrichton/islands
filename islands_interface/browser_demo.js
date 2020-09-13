function new_channel(subtopic, screen_name) {
  return socket.channel("game:" + subtopic, { screen_name: screen_name });
}

function join(channel) {
  channel
    .join()
    .receive("ok", (response) => {
      console.log("Joined successfully!", response);
    })
    .receive("error", (response) => {
      console.log("Unable to join", response);
    });
}

function leave(channel) {
  channel
    .leave()
    .receive("ok", (response) => {
      console.log("Left successfully", response);
    })
    .receive("error", (response) => {
      console.log("Unable to leave", response);
    });
}

function new_game(channel) {
  channel
    .push("new_game")
    .receive("ok", (response) => {
      console.log("New Game!", response);
    })
    .receive("error", (response) => {
      console.log("Unable to start a new game.", response);
    });
}

function add_player(channel, player) {
  channel.push("add_player", player).receive("error", (response) => {
    console.log("Unable to add new player: " + player, response);
  });
}

function position_island(channel, player, island, row, col) {
  var params = { player: player, island: island, row: row, col: col };
  channel
    .push("position_island", params)
    .receive("ok", (response) => {
      console.log("Island positioned!", response);
    })
    .receive("error", (response) => {
      console.log("Unable to position island.", response);
    });
}

function set_islands(channel, player) {
  channel
    .push("set_islands", player)
    .receive("ok", (response) => {
      console.log("Here is the board:");
      console.dir(response.board);
    })
    .receive("error", (response) => {
      console.log("Unable to set islands for: " + player, response);
    });
}

// --------

// Player1
var socket = new window.Phoenix.Socket("/socket", {});
socket.connect();
var game_channel = new_channel("Player 1", "P1");
join(game_channel);

game_channel.on("player_added", (response) => {
  console.log("Player Added", response);
});

game_channel.on("player_set_islands", (response) => {
  console.log("Player Set Islands", response);
});

// Player2
var socket = new window.Phoenix.Socket("/socket", {});
socket.connect();
var game_channel = new_channel("Player 2", "Chrichton");
join(game_channel);

game_channel.on("player_added", (response) => {
  console.log("Player Added", response);
});

game_channel.on("player_set_islands", (response) => {
  console.log("Player Set Islands", response);
});

add_player(game_channel, "diva");

position_island(game_channel, "player2", "atoll", 1, 1);
position_island(game_channel, "player2", "dot", 1, 5);
position_island(game_channel, "player2", "l_shape", 1, 7);
position_island(game_channel, "player2", "s_shape", 5, 1);
position_island(game_channel, "player2", "square", 5, 5);
position_island(game_channel, "player1", "dot", 1, 1);

set_islands(game_channel, "player2");
