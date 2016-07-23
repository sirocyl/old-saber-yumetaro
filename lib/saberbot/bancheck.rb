# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  def SaberBot.bancheck
    Bans.each do |uid, details|
      if details[:stop_time] <= Time.now.to_i
        server = BotObject.servers[details[:sid]]
        user = server.bans.find {|user| user.id == uid}
        server.unban(user)
        Server_channels[server][Config["modlog_channel"]].send("**Unbanned:** #{details[:mention]} || #{details[:distinct]}")
        Bans.delete(uid)
      end
    end
  end
end
