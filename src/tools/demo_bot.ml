module C = Calculon
module CW = Calculon_web

let plugins : C.Plugin.t list = [
  C.Plugin_social.plugin;
  C.Plugin_factoids.plugin;
  C.Plugin_state.plugin;
  CW.Plugin_web.plugin;
  Calculon_extras.Plugin_markcough.plugin;
]

let config = {
  C.Config.default with
  C.Config.
  server = "irc.freenode.net";
  port = 7000;
  username = "test_bot";
  realname = "test_bot";
  nick = "test_bot";
  channel = "##test";
}

let () =
  try
    (* update with CLI parameters *)
    let config = C.Config.parse config Sys.argv in
    C.Run_main.main config plugins |> Lwt_main.run
  with
    | Arg.Help msg -> print_endline msg
    | Arg.Bad msg -> prerr_endline msg; exit 1
