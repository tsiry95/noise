// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2012-2015 Noise Developers (https://launchpad.net/noise)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * The Noise authors hereby grant permission for non-GPL compatible
 * GStreamer plugins to be used and distributed together with GStreamer
 * and Noise. This permission is above and beyond the permissions granted
 * by the GPL license by which Noise is covered. If you modify this code
 * you may extend this exception to your version of the code, but you are not
 * obligated to do so. If you do not wish to do so, delete this exception
 * statement from your version.
 *
 * Authored by: Corentin Noël <corentin@elementary.io>
 */

public class Noise.LocalStaticPlaylist : StaticPlaylist {
    private Gda.Connection connection;

    /**
     * Metadata Fields
     */
    private string _name = null;
    public override string name {
        get {
            if (_name != null)
                return _name;

            _name = Database.query_field (rowid, connection, Database.Playlists.TABLE_NAME, "name").dup_string ();
            return _name;
        }
        set {
            _name = value;
            Database.set_field (rowid, connection, Database.Playlists.TABLE_NAME, "name", Database.make_string_value (value));
        }
    }

    public LocalStaticPlaylist (int64 rowid, Gda.Connection connection) {
        this.rowid = rowid;
        this.connection = connection;
        var all = Database.query_field (rowid, connection, Database.Playlists.TABLE_NAME, "media").dup_string ();
        foreach (var id in all.split (";")) {
            medias.add (libraries_manager.local_library.media_from_id (int64.parse (id)));
        }
    }

    construct {
        updated.connect ((old_name) => {
            update_database ();
        });
    }

    private void update_database () {
        var rowid_value = GLib.Value (typeof (int64));
        rowid_value.set_int64 (rowid);
        var col_names = new GLib.SList<string> ();
        col_names.append ("name");
        col_names.append ("media");
        var values = new GLib.SList<Value?> ();
        var sb = new StringBuilder ();
        foreach (var m in medias) {
            if (sb.len != 0)
                sb.append_c (';');

            sb.append_printf ("%lld", m.rowid);
        }

        values.append (Database.make_string_value (name));
        values.append (Database.make_string_value (sb.str));
        try {
            connection.update_row_in_table_v (Database.Playlists.TABLE_NAME, "rowid", rowid_value, col_names, values);
        } catch (Error e) {
            critical (e.message);
        }
    }
}
