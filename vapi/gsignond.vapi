/* gsignond.vapi generated by vapigen-0.26, do not modify. */

[CCode (cprefix = "GSignond", gir_namespace = "gSignond", gir_version = "1.0", lower_case_cprefix = "gsignond_")]
namespace GSignond {
	[CCode (cheader_filename = "gsignond/gsignond.h", type_id = "gsignond_access_control_manager_get_type ()")]
	public class AccessControlManager : GLib.Object {
		[CCode (has_construct_function = false)]
		protected AccessControlManager ();
		public virtual bool acl_is_valid (GSignond.SecurityContext peer_ctx, GSignond.SecurityContextList identity_acl);
		public virtual bool peer_is_allowed_to_use_identity (GSignond.SecurityContext peer_ctx, GSignond.SecurityContext owner_ctx, GSignond.SecurityContextList identity_acl);
		public virtual bool peer_is_owner_of_identity (GSignond.SecurityContext peer_ctx, GSignond.SecurityContext owner_ctx);
		public virtual GSignond.SecurityContext security_context_of_keychain ();
		public virtual void security_context_of_peer (GSignond.SecurityContext peer_ctx, int peer_fd, string peer_service, string peer_app_ctx);
		[NoAccessorMethod]
		public GSignond.Config config { owned get; construct; }
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", type_id = "gsignond_config_get_type ()")]
	public class Config : GLib.Object {
		[CCode (has_construct_function = false)]
		public Config ();
		public int get_integer (string key);
		public unowned string get_string (string key);
		public void set_integer (string key, int value);
		public void set_string (string key, string value);
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", type_id = "gsignond_credentials_get_type ()")]
	public class Credentials : GLib.Object {
		[CCode (has_construct_function = false)]
		public Credentials ();
		public bool equal (GSignond.Credentials two);
		public uint32 get_id ();
		public unowned string get_password ();
		public unowned string get_username ();
		public bool set_data (uint32 id, string username, string password);
		public bool set_id (uint32 id);
		public bool set_password (string password);
		public bool set_username (string username);
	}
	[CCode (cheader_filename = "gsignond/gsignond.h")]
	public class Dictionary : GLib.HashTable<string,GLib.Variant> {
		[CCode (has_construct_function = false)]
		public Dictionary ();
		public bool contains (string key);
		public unowned GLib.Variant @get (string key);
		public bool get_boolean (string key, out bool value);
		public bool get_int32 (string key, out int value);
		public bool get_int64 (string key, out int64 value);
		public unowned string get_string (string key);
		public bool get_uint32 (string key, out uint value);
		public bool get_uint64 (string key, out uint64 value);
		public Dictionary.new_from_variant (GLib.Variant variant);
		public bool remove (string key);
		public bool @set (string key, GLib.Variant value);
		public bool set_boolean (string key, bool value);
		public bool set_int32 (string key, int value);
		public bool set_int64 (string key, int64 value);
		public bool set_string (string key, string value);
		public bool set_uint32 (string key, uint32 value);
		public bool set_uint64 (string key, uint64 value);
		public GLib.Variant to_variant ();
		public unowned GLib.VariantBuilder to_variant_builder ();
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", type_id = "gsignond_extension_get_type ()")]
	public class Extension : GLib.Object {
		[CCode (has_construct_function = false)]
		protected Extension ();
		public virtual unowned GSignond.AccessControlManager get_access_control_manager (GSignond.Config config);
		[NoWrapper]
		public virtual unowned string get_extension_name ();
		[NoWrapper]
		public virtual uint32 get_extension_version ();
		public unowned string get_name ();
		public virtual unowned GSignond.SecretStorage get_secret_storage (GSignond.Config config);
		public virtual unowned GSignond.StorageManager get_storage_manager (GSignond.Config config);
		public uint32 get_version ();
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", type_id = "gsignond_secret_storage_get_type ()")]
	public class SecretStorage : GLib.Object {
		[CCode (has_construct_function = false)]
		protected SecretStorage ();
		public virtual bool check_credentials (GSignond.Credentials creds);
		public virtual bool clear_db ();
		public virtual bool close_db ();
		public virtual unowned GLib.Error get_last_error ();
		public virtual bool is_open_db ();
		public virtual GSignond.Credentials load_credentials (uint32 id);
		public GLib.HashTable<void*,void*> load_data (uint32 id, uint32 method);
		public virtual bool open_db ();
		public virtual bool remove_credentials (uint32 id);
		public virtual bool remove_data (uint32 id, uint32 method);
		public virtual bool update_credentials (GSignond.Credentials creds);
		public virtual bool update_data (uint32 id, uint32 method, GSignond.Dictionary data);
		[NoAccessorMethod]
		public GSignond.Config config { owned get; construct; }
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gsignond_security_context_get_type ()")]
	[Compact]
	public class SecurityContext {
		public weak string app_ctx;
		public weak string sys_ctx;
		[CCode (has_construct_function = false)]
		public SecurityContext ();
		public bool check (GSignond.SecurityContext test);
		public int compare (GSignond.SecurityContext ctx2);
		public GSignond.SecurityContext copy ();
		public void free ();
		[CCode (has_construct_function = false)]
		public SecurityContext.from_values (string system_context, string application_context);
		public static GSignond.SecurityContext from_variant (GLib.Variant variant);
		public unowned string get_application_context ();
		public unowned string get_system_context ();
		public bool match (GSignond.SecurityContext ctx2);
		public void set_application_context (string application_context);
		public void set_system_context (string system_context);
		public GLib.Variant to_variant ();
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", copy_function = "gsignond_security_context_list_copy", free_function = "gsignond_security_context_list_free", type_id = "gsignond_security_context_list_get_type ()")]
	public class SecurityContextList : GLib.List<GSignond.SecurityContext> {
		public GSignond.SecurityContextList copy ();
		public SecurityContextList.from_variant (GLib.Variant variant);
		public GLib.Variant to_variant ();
	}
	[CCode (cheader_filename = "gsignond/gsignond.h")]
	public class SessionData : GSignond.Dictionary {
		[CCode (has_construct_function = false)]
		protected SessionData ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_caption ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_network_proxy ();
		[CCode (instance_pos = 0.5)]
		public bool get_network_timeout (uint32 network_timeout);
		[CCode (instance_pos = 0.5)]
		public unowned string get_realm ();
		[CCode (instance_pos = 0.5)]
		public bool get_renew_token (bool renew_token);
		[CCode (instance_pos = 0.5)]
		public unowned string get_secret ();
		[CCode (instance_pos = 0.5)]
		public bool get_ui_policy (GSignond.UiPolicy ui_policy);
		[CCode (instance_pos = 0.5)]
		public unowned string get_username ();
		[CCode (instance_pos = 0.5)]
		public bool get_window_id (uint32 window_id);
		[CCode (instance_pos = 0.5)]
		public void set_allowed_realms (GLib.Sequence realms);
		[CCode (instance_pos = 0.5)]
		public void set_caption (string caption);
		[CCode (instance_pos = 0.5)]
		public void set_network_proxy (string network_proxy);
		[CCode (instance_pos = 0.5)]
		public void set_network_timeout (uint32 network_timeout);
		[CCode (instance_pos = 0.5)]
		public void set_realm (string realm);
		[CCode (instance_pos = 0.5)]
		public void set_renew_token (bool renew_token);
		[CCode (instance_pos = 0.5)]
		public void set_secret (string secret);
		[CCode (instance_pos = 0.5)]
		public void set_ui_policy (GSignond.UiPolicy ui_policy);
		[CCode (instance_pos = 0.5)]
		public void set_username (string username);
		[CCode (instance_pos = 0.5)]
		public void set_window_id (uint32 window_id);
	}
	[CCode (cheader_filename = "gsignond/gsignond.h")]
	public class SignonuiData : GSignond.Dictionary {
		[CCode (has_construct_function = false)]
		protected SignonuiData ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_captcha_response ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_captcha_url ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_caption ();
		[CCode (instance_pos = 0.5)]
		public bool get_confirm (bool confirm);
		[CCode (instance_pos = 0.5)]
		public unowned string get_final_url ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_forgot_password ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_forgot_password_url ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_message ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_open_url ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_password ();
		[CCode (instance_pos = 0.5)]
		public bool get_query_error (GSignond.SignonuiError error);
		[CCode (instance_pos = 0.5)]
		public bool get_query_password (bool query_password);
		[CCode (instance_pos = 0.5)]
		public bool get_query_username (bool query_username);
		[CCode (instance_pos = 0.5)]
		public bool get_remember_password (bool remember_password);
		[CCode (instance_pos = 0.5)]
		public unowned string get_request_id ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_test_reply ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_title ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_url_response ();
		[CCode (instance_pos = 0.5)]
		public unowned string get_username ();
		[CCode (instance_pos = 0.5)]
		public void set_captcha_response (string response);
		[CCode (instance_pos = 0.5)]
		public void set_captcha_url (string url);
		[CCode (instance_pos = 0.5)]
		public void set_caption (string caption);
		[CCode (instance_pos = 0.5)]
		public void set_confirm (bool confirm);
		[CCode (instance_pos = 0.5)]
		public void set_final_url (string url);
		[CCode (instance_pos = 0.5)]
		public void set_forgot_password (string forgot);
		[CCode (instance_pos = 0.5)]
		public void set_forgot_password_url (string url);
		[CCode (instance_pos = 0.5)]
		public void set_message (string message);
		[CCode (instance_pos = 0.5)]
		public void set_open_url (string url);
		[CCode (instance_pos = 0.5)]
		public void set_password (string password);
		[CCode (instance_pos = 0.5)]
		public void set_query_error (GSignond.SignonuiError error);
		[CCode (instance_pos = 0.5)]
		public void set_query_password (bool query);
		[CCode (instance_pos = 0.5)]
		public void set_query_username (bool query);
		[CCode (instance_pos = 0.5)]
		public void set_remember_password (bool remember);
		[CCode (instance_pos = 0.5)]
		public void set_request_id (string id);
		[CCode (instance_pos = 0.5)]
		public void set_test_reply (string reply);
		[CCode (instance_pos = 0.5)]
		public void set_title (string title);
		[CCode (instance_pos = 0.5)]
		public void set_url_response (string response);
		[CCode (instance_pos = 0.5)]
		public void set_username (string username);
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", type_id = "gsignond_storage_manager_get_type ()")]
	public class StorageManager : GLib.Object {
		public string location;
		[CCode (has_construct_function = false)]
		protected StorageManager ();
		public virtual bool delete_storage ();
		public virtual bool filesystem_is_mounted ();
		public virtual bool initialize_storage ();
		public virtual unowned string mount_filesystem ();
		public virtual bool storage_is_initialized ();
		public virtual bool unmount_filesystem ();
		[NoAccessorMethod]
		public GSignond.Config config { owned get; construct; }
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", type_cname = "GSignondPluginInterface", type_id = "gsignond_plugin_get_type ()")]
	public interface Plugin : GLib.Object {
		public abstract void cancel ();
		public abstract void refresh (GSignond.SignonuiData ui_data);
		public abstract void request (GSignond.SessionData session_data);
		public abstract void request_initial (GSignond.SessionData session_data, GSignond.Dictionary identity_method_cache, string mechanism);
		public abstract void user_action_finished (GSignond.SignonuiData ui_data);
		[CCode (array_length = false, array_null_terminated = true)]
		[NoAccessorMethod]
		public abstract string[] mechanisms { owned get; }
		[NoAccessorMethod]
		public abstract string type { owned get; }
		[HasEmitter]
		public signal void error (GLib.Error error);
		[HasEmitter]
		public signal void refreshed (GLib.HashTable<void*,void*> ui_data);
		[HasEmitter]
		public signal void response (GLib.HashTable<void*,void*> session_data);
		[HasEmitter]
		public signal void response_final (GLib.HashTable<void*,void*> session_data);
		[HasEmitter]
		public signal void status_changed (GSignond.PluginState state, string message);
		[HasEmitter]
		public signal void store (GLib.HashTable<void*,void*> identity_method_cache);
		[HasEmitter]
		public signal void user_action_required (GLib.HashTable<void*,void*> ui_data);
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", cprefix = "GSIGNOND_PLUGIN_STATE_", type_id = "gsignond_plugin_state_get_type ()")]
	public enum PluginState {
		NONE,
		RESOLVING,
		CONNECTING,
		SENDING_DATA,
		WAITING,
		USER_PENDING,
		REFRESHING,
		PROCESS_PENDING,
		STARTED,
		CANCELING,
		DONE,
		HOLDING
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", cprefix = "SIGNONUI_ERROR_", has_type_id = false)]
	public enum SignonuiError {
		NONE,
		GENERAL,
		NO_SIGNONUI,
		BAD_PARAMETERS,
		CANCELED,
		NOT_AVAILABLE,
		BAD_URL,
		BAD_CAPTCHA,
		BAD_CAPTCHA_URL,
		REFRESH_FAILED,
		FORBIDDEN,
		FORGOT_PASSWORD
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", cprefix = "GSIGNOND_UI_POLICY_", has_type_id = false)]
	public enum UiPolicy {
		DEFAULT,
		REQUEST_PASSWORD,
		NO_USER_INTERACTION,
		VALIDATION
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", cprefix = "GSIGNOND_ERROR_")]
	public errordomain Error {
		NONE,
		UNKNOWN,
		INTERNAL_SERVER,
		INTERNAL_COMMUNICATION,
		PERMISSION_DENIED,
		ENCRYPTION_FAILURE,
		AUTH_SERVICE_ERR,
		METHOD_NOT_KNOWN,
		SERVICE_NOT_AVAILABLE,
		INVALID_QUERY,
		IDENTITY_ERR,
		METHOD_NOT_AVAILABLE,
		IDENTITY_NOT_FOUND,
		STORE_FAILED,
		REMOVE_FAILED,
		SIGN_OUT_FAILED,
		IDENTITY_OPERATION_CANCELED,
		CREDENTIALS_NOT_AVAILABLE,
		REFERENCE_NOT_FOUND,
		AUTH_SESSION_ERR,
		MECHANISM_NOT_AVAILABLE,
		MISSING_DATA,
		INVALID_CREDENTIALS,
		NOT_AUTHORIZED,
		WRONG_STATE,
		OPERATION_NOT_SUPPORTED,
		NO_CONNECTION,
		NETWORK,
		SSL,
		RUNTIME,
		SESSION_CANCELED,
		TIMED_OUT,
		USER_INTERACTION,
		OPERATION_FAILED,
		ENCRYPTION_FAILED,
		TOS_NOT_ACCEPTED,
		FORGOT_PASSWORD,
		METHOD_OR_MECHANISM_NOT_ALLOWED,
		INCORRECT_DATE,
		USER_ERR;
		public static GLib.Error new_from_variant (GLib.Variant @var);
		public static GLib.Quark quark ();
		public static GLib.Variant to_variant (GLib.Error error);
	}
	[CCode (cheader_filename = "gsignond/gsignond.h", cname = "GSIGNOND_CONFIG_DBUS_TIMEOUTS")]
	public const string CONFIG_DBUS_TIMEOUTS;
	[CCode (cheader_filename = "gsignond/gsignond.h", cname = "GSIGNOND_CONFIG_GENERAL")]
	public const string CONFIG_GENERAL;
	[CCode (cheader_filename = "gsignond/gsignond.h")]
	public static string generate_nonce ();
	[CCode (cheader_filename = "gsignond/gsignond.h")]
	public static bool is_host_in_domain (string host, string domain);
	[CCode (array_length = false, array_null_terminated = true, cheader_filename = "gsignond/gsignond.h")]
	public static string[] sequence_to_array (GLib.Sequence seq);
	[CCode (cheader_filename = "gsignond/gsignond.h")]
	public static GLib.Variant sequence_to_variant (GLib.Sequence seq);
	[CCode (cheader_filename = "gsignond/gsignond.h")]
	public static bool wipe_directory (string dirname);
	[CCode (cheader_filename = "gsignond/gsignond.h")]
	public static bool wipe_file (string filename);
}
