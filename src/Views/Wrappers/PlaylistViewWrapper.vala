// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2012 Noise Developers (http://launchpad.net/noise)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Authored by: Victor Eduardo <victoreduardm@gmail.com>
 */

public class Noise.PlaylistViewWrapper : ViewWrapper {
    public TreeViewSetup tvs;
    public signal void button_clicked (Playlist p);
    private Gtk.Action[] actions = null;
    private string message_head;
    private string message_body;

    public PlaylistViewWrapper (Playlist playlist, ViewWrapper.Hint hint, TreeViewSetup tvs, Library library) {
        base (hint, library);
        this.tvs = tvs;

        this.playlist = playlist;

        list_view = new ListView (this, this.tvs);
        embedded_alert = new Granite.Widgets.EmbeddedAlert ();

        // Refresh view layout
        pack_views ();

        // Do initial population. Further additions and removals will be handled
        // by the handlers connected below through connect_data_signals()
        switch (hint) {
            case Hint.READ_ONLY_PLAYLIST:
                message_head = _("No Songs");
                message_body = _("Updating playlist. Please wait.");
                break;
            case Hint.PLAYLIST:
                message_head = _("No Songs");
                message_body = _("To add songs to this playlist, use the <b>secondary click</b> on an item and choose <b>Add to Playlist</b>.");
                break;
            case Hint.SMART_PLAYLIST:
                var action = new Gtk.Action ("smart-playlist-rules-edit",
                                             _("Edit Smart Playlist"),
                                             null,
                                             null);
                // Connect to the 'activate' signal
                action.activate.connect (() => {
                    button_clicked (playlist);
                });

                actions = new Gtk.Action[1];
                actions[0] = action;

                message_head = _("No Songs");
                message_body = _("This playlist will be automatically populated with songs that match its rules. To modify these rules, use the <b>secondary click</b> on it in the sidebar and click on <b>Edit</b>. Optionally, you can click on the button below.");
                break;

            default:
                assert_not_reached ();
        }

        set_media_async.begin (playlist.medias);
        connect_data_signals ();
    }

    private void connect_data_signals () {
        switch (hint) {
            case Hint.READ_ONLY_PLAYLIST:
            case Hint.PLAYLIST:
                var p = (StaticPlaylist)playlist;

                // Connect to playlist signals
                if (p != null) {
                    p.media_added.connect (on_playlist_media_added);
                    p.media_removed.connect (on_playlist_media_removed);
                    p.cleared.connect (on_playlist_cleared);
                    p.request_play.connect (() => {App.player.clearCurrent(); play_first_media (true);App.player.getNext(true);});
                }
            break;
            
            case Hint.SMART_PLAYLIST:
                var p = (SmartPlaylist)playlist;

                // Connect to smart playlist signals
                if (p != null) {
                    p.media_added.connect (on_playlist_media_added);
                    p.media_removed.connect (on_playlist_media_removed);
                    p.cleared.connect (on_playlist_cleared);
                    p.request_play.connect (() => {App.player.clearCurrent(); play_first_media (true);App.player.getNext(true);});
                }
            break;

            default:
                assert_not_reached ();
        }
    }

    public void set_no_media_alert_message (string head, string body) {
        message_head = head;
        message_body = body;
    }

    protected override void set_no_media_alert () {
        // show alert if there's no media
        assert (has_embedded_alert);

        embedded_alert.set_alert (message_head, message_body, actions, true, Gtk.MessageType.INFO);
    }

    private async void on_playlist_media_added (Gee.Collection<Media> to_add) {
        yield add_media_async (to_add);
    }

    private async void on_playlist_media_removed (Gee.Collection<Media> to_remove) {
        yield remove_media_async (to_remove);
    }

    private async void on_playlist_cleared () {
        yield set_media_async (new Gee.ArrayQueue<Media> ());
    }
}

