let
	surface_laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOFnkZqaaH26HE3eP59/IfPsynkujINUyCnofPTC4uw1";
in
{
	"google_api_key.age".publicKeys = [ surface_laptop ];
}
