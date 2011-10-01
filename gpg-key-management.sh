#!/bin/bash
#
# Copyright (C) 2011 Reece H. Dunn
# License: LGPLv3+
#
# Helper script to backup and restore gpg public/private keys.

COMMAND=$1
shift

case "$COMMAND" in
	list)
		gpg --list-keys | grep "pub  " | sed -e 's,.*/,,g' -e 's, .*,,g'
		;;
	public)
		gpg --armour --export $1
		;;
	register)
		gpg ---send-keys --keyserver hkp://subkeys.pgp.net $1
		gpg --refresh-keys --keyserver hkp://subkeys.pgp.net
		;;
	backup)
		gpg -ao $1-pub.key --export $1
		gpg -ao $1-private.key --export-secret-keys $1
		gpg --output $1-revoke.key --gen-revoke $1
		;;
	restore)
		gpg --import $1-pub.key
		gpg --import $1-private.key
		;;
	revoke)
		gpg --import $1-revoke.key
		;;
	*)
		echo "usage: $0 command args"
		echo "where command is:"
		echo "   list         -- list the available gpg keys"
		echo "   public   KEY -- generate an ASCII version of the public key suitable for email"
		echo "   register KEY -- register the key with hkp://subkeys.pgp.net"
		echo "   backup   KEY -- create the public, private and revoke keys for the specified key (from $0 list)"
		echo "   restore  KEY -- restore the public and private keys from the backup"
		echo "   revoke   KEY -- revoke the specified key (need to re-register afterward)"
		;;
esac
