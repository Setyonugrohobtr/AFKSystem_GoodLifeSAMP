#include <a_samp>

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

#pragma tabsize 0


//Colors
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_GREEN 0x00FF00AA
#define COLOR_RED 0xFF0000AA
#define COLOR_LIGHTBLUE                 0x33CCFFAA
#define COLOR_YELLOW 0xFFFF00AA
enum Player
{
    AFKstatus
}
new PlayerInfo[MAX_PLAYERS][Player];
public OnFilterScriptInit()
{
        print("\n--------------------------------------");
        print(" AFK/BRB System By Setyo Nugroho and Kingina IS Loaded Successfully !");
        print("--------------------------------------\n");
        return 1;
}

public OnFilterScriptExit()
{
        return 1;
}

dcmd_afk(playerid, params[])
        {
            #pragma unused params
                new string[256];
                if (PlayerInfo[playerid][AFKstatus] == 1)
                {
                        SendClientMessage(playerid, COLOR_RED, "ERROR: Your status is already AFK/BRB!");
                        return 1;
                }

                else if (PlayerInfo[playerid][AFKstatus] == 0)
                {
                        new pname[MAX_PLAYER_NAME];
                        GetPlayerName(playerid, pname, sizeof(pname));
                        format(string, sizeof(string), "%s (ID:%d) is away from keyboard!", pname,playerid);
                        SendClientMessageToAll(COLOR_YELLOW, string);
                        TogglePlayerControllable(playerid,0);
                        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid) + 50);
                        PlayerInfo[playerid][AFKstatus] = 1;
                        return 1;
                }
return 0;
}

dcmd_brb(playerid, params[])
        {
            #pragma unused params
                new string[256];
                if (PlayerInfo[playerid][AFKstatus] == 1)
                {
                        SendClientMessage(playerid, COLOR_RED, "ERROR: You are Aready Afk/And or Brb");
                        return 1;
                }

                else if (PlayerInfo[playerid][AFKstatus] == 0)
                {
                        new pname[MAX_PLAYER_NAME];
                        GetPlayerName(playerid, pname, sizeof(pname));
                        format(string, sizeof(string), "%s (ID:%d) Will Be Right Back (BRB)", pname,playerid);
                        SendClientMessageToAll(COLOR_GREEN, string);
                        TogglePlayerControllable(playerid,0);
                        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid) + 50);
                        PlayerInfo[playerid][AFKstatus] = 1;
                        return 1;
 }
return 0;
}

dcmd_back(playerid, params[])
        {
                #pragma unused params
                new string [256];
                if (PlayerInfo[playerid][AFKstatus] == 0)
                {
                        SendClientMessage(playerid, COLOR_RED, "ERROR: You are Aready Back!");
                        return 1;
                }

                else if (PlayerInfo[playerid][AFKstatus] == 1)
                {
                        new pname[MAX_PLAYER_NAME];
                        GetPlayerName(playerid, pname, sizeof(pname));
                        format(string, sizeof(string), "%s (ID:%d) has Came Back!!!", pname,playerid);
                        SendClientMessageToAll(COLOR_GREEN, string);
                        TogglePlayerControllable(playerid,1);
                        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid) - 50);
                        PlayerInfo[playerid][AFKstatus] = 0;
                        return 1;
 }
return 0;
}


dcmd_afkplayers( playerid, params[ ] )
{
    #pragma unused params
        new count = 0;
        new name[MAX_PLAYER_NAME];
                new string[128];
        //
                SendClientMessage(playerid, COLOR_WHITE, "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "The Afk List:");
                SendClientMessage(playerid, COLOR_WHITE, "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
        for(new i = 0; i < MAX_PLAYERS; i++)
                {
                        if (IsPlayerConnected(i))
                        {

                            if(PlayerInfo[i][AFKstatus] == 1)
                            {
                                        GetPlayerName(i, name, sizeof(name));
                                        format(string, 256, "AFK> %s{FFFFFF} (ID:%d)", name,i );
                                        SendClientMessage(playerid, COLOR_YELLOW, string);
                                count++;
                                }
                        }

                }
                if (count == 0)
                {
                SendClientMessage(playerid, COLOR_RED, "NoOne Is Afk or Brb");
                }
                SendClientMessage(playerid, COLOR_WHITE, "-=---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
                return 1;
}

public OnPlayerConnect(playerid)
{
    PlayerInfo[playerid][AFKstatus] = 0;
    new string[256];
    new pname[MAX_PLAYER_NAME];
	format(string, sizeof(string), "This server is using AFK System by {f0ff00}Kingina!", pname,playerid);
	SendClientMessageToAll(COLOR_GREEN, string);
        return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    PlayerInfo[playerid][AFKstatus] = 0;
        return 1;
}



public OnPlayerText(playerid, text[])
{
        if (PlayerInfo[playerid][AFKstatus] == 1)
        {
                SendClientMessage(playerid, COLOR_RED, "Dude Use /back To Speak Again Please!!");
                return 0;
        }

        else if (PlayerInfo[playerid][AFKstatus] == 0)
        {
                return 1;
        }
        return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
        dcmd(afk,3,cmdtext);
        dcmd(brb,3,cmdtext);
        dcmd(back,4,cmdtext);
        dcmd(afkplayers,10,cmdtext);
        return 0;
}
//Jangan Hapus Credit yang ada, maded by Setyo Nugroho dan Kingina (GoodLife Server)
