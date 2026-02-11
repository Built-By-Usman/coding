from pwdlib import PasswordHash
PasswordHash=PasswordHash.recommended()


def get_hashed_password(password):
    return PasswordHash.hash(password)