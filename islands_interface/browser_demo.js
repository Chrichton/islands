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

function guess_coordinate(channel, player, row, col) {
    var params = { player: player, row: row, col: col };
    channel.push("guess_coordinate", params)
      .receive("error", (response) => {
          console.log("Unable to guess a coordinate: " + player, response);
      });
  }
  
// --------

// Player1
var socket = new window.Phoenix.Socket("/socket", {});
socket.connect();
var game_channel = new_channel("moon", "moon");
join(game_channel);

game_channel.on("player_added", (response) => {
  console.log("Player Added", response);
});

game_channel.on("player_set_islands", (response) => {
  console.log("Player Set Islands", response);
});

game_channel.on("player_guessed_coordinate", response => { 
    console.log("Player Guessed Coordinate: ", response.result)
});

new_game(game_channel)

// --- After Player2 set_islands

iex> state_data = :sys.get_state(via)

iex> state_data = :sys.replace_state(via, fn state_data ->
%{state_data | rules: %Rules{state: :player1_turn}}
end)

guess_coordinate(game_channel, "player1", 10, 1) // misses


// Player2
var socket = new window.Phoenix.Socket("/socket", {});
socket.connect();
var game_channel = new_channel("moon", "diva");
join(game_channel);

game_channel.on("player_added", (response) => {
  console.log("Player Added", response);
});

game_channel.on("player_set_islands", (response) => {
  console.log("Player Set Islands", response);
});

game_channel.on("player_guessed_coordinate", response => { 
    console.log("Player Guessed Coordinate: ", response.result)
});

add_player(game_channel, "diva");

position_island(game_channel, "player2", "atoll", 1, 1);
position_island(game_channel, "player2", "dot", 1, 5);
position_island(game_channel, "player2", "l_shape", 1, 7);
position_island(game_channel, "player2", "s_shape", 5, 1);
position_island(game_channel, "player2", "square", 5, 5);

set_islands(game_channel, "player2");

// ---- After Player1 guessed

guess_coordinate(game_channel, "player2", 1, 1) // hit and game over