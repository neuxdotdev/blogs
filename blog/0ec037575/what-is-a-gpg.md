# GPG (GnuPG) & Gpg4win Guide

## What is GPG?

**GPG** (GNU Privacy Guard) is free encryption software that implements the OpenPGP standard for:

- **Encrypting emails/files** (end-to-end encryption)
- **Digital signatures** (verifying authenticity)
- **Secure communication** using public-key cryptography

> **OpenPGP** = Open standard for Pretty Good Privacy encryption

---

## What is Gpg4win?

**Gpg4win** is a Windows software bundle that includes:

| Component     | Purpose                                 |
| ------------- | --------------------------------------- |
| **GnuPG**     | Core encryption engine                  |
| **Kleopatra** | GUI certificate manager                 |
| **GpgOL**     | Outlook plugin for email encryption     |
| **GpgEX**     | Explorer plugin for file encryption     |
| **PDF tool**  | PDF signing/verification (experimental) |

---

## How It Works - Simplified

### Basic Concept

```
Your Public Key (Share with everyone)    Your Private Key (Keep secret!)

    Someone encrypts                 You decrypt with
    to you with this                 your private key
```

### Key Features

- **End-to-end encryption** - Only intended recipient can read
- **Digital signatures** - Prove message authenticity
- **Web Key Directory (WKD)** - Easy public key discovery via email domains
- **Open standard** - Compatible with many email clients

---

## Quick Start Guide

### For Windows Users

1. **Download Gpg4win** from [gpg4win.org](https://gpg4win.org)
2. **Install** with default settings
3. **Launch Kleopatra** to create your first key pair
4. **Configure your email client** (Thunderbird/Outlook)
5. **Share your public key** via keyserver or WKD

### For Command Line (All Platforms)

```bash
# Generate new key pair
gpg --full-generate-key

# Encrypt a file
gpg --encrypt --recipient "email@example.com" file.txt

# Decrypt a file
gpg --decrypt file.txt.gpg

# List your keys
gpg --list-keys
```

---

## Common Use Cases

| Scenario                     | GPG Solution                       |
| ---------------------------- | ---------------------------------- |
| Secure email communication   | Email encryption                   |
| Verifying software downloads | Digital signatures                 |
| Encrypting sensitive files   | File encryption                    |
| Password management          | Store passwords in encrypted files |

---

## Important Updates & Timeline

```

   Date                        Event

 2023-11-29   LibrePGP draft published (OpenPGP v4 update)
 2023-08-04   Community forum modernized
 2023-07-14   PDF signing with Okular in Gpg4win 4.2
 2022-12-20   GnuPG 2.4.0 - 25th anniversary release
 2021-12-21   Gpg4win 4 released - ECC as default for new keys
 2021-04-08   GnuPG 2.3.0 - New crypto algorithm defaults

```

---

## Tips & Best Practices

### **Key Management**

- Generate **4096-bit RSA keys** (minimum 2048-bit)
- Set **reasonable expiration dates** (1-2 years)
- Create **revocation certificates** and store securely
- Regularly **refresh keys** from keyservers

### **Email Encryption**

- Use **Thunderbird + Enigmail** for best experience
- Configure **Web Key Directory (WKD)** for easy discovery
- **Sign all encrypted emails** for authenticity
- **Verify recipient keys** before first use

### **Security**

- Protect your **private key with strong passphrase**
- Consider **smartcards** for hardware key storage
- **Never share private keys** across devices
- Use **separate keys** for different purposes

---

## Getting Help

### Documentation

- **Official Docs**: [gnupg.org/documentation](https://gnupg.org/documentation)
- **Gpg4win Guide**: [gpg4win.org/help.html](https://gpg4win.org/help.html)

### Community & Support

- **Wiki**: [wiki.gnupg.org](https://wiki.gnupg.org)
- **Mailing Lists**: gnupg-users@gnupg.org
- **IRC**: #gnupg on Libera.Chat

### Troubleshooting

```
Common Issues:
 "No secret key"  Import/select correct private key
 "Bad signature"  Update sender's public key
 WKD not working  Check DNS TXT records
```

---

## For Developers

### Integration Options

```python
# Python example using python-gnupg
import gnupg

gpg = gnupg.GPG()
encrypted_data = gpg.encrypt(data, recipients)
decrypted_data = gpg.decrypt(encrypted_data)
```

### APIs & Libraries

- **GPGME** (GPG Made Easy) - Main C API
- **Java**: Bouncy Castle PGP
- **Python**: python-gnupg, PGPy
- **Go**: golang.org/x/crypto/openpgp

### Web Key Directory (WKD)

```http
GET /.well-known/openpgpkey/hu/example.org
Host: example.org
```

Returns public keys for email addresses in domain

---

## Additional Resources

- **OpenPGP Standard**: [RFC 4880](https://tools.ietf.org/html/rfc4880)
- **Key Servers**: [keys.openpgp.org](https://keys.openpgp.org)
- **Compatible Software**: [OpenPGP.org](https://www.openpgp.org/software/)
- **Testing Tools**: [gpgtools.tenderapp.com](https://gpgtools.tenderapp.com)

---

<div align="center">
  <strong>Remember:</strong> Encryption is only as strong as your key management practices!
</div>

> _"Privacy is not something that I'm merely entitled to, it's an absolute prerequisite."_ Marlon Brando
