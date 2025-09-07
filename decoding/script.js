// decode.js
const file1 = "VGhlIGtleSB3aWxsIGJlIG9uZSBiZWZvcmUgaXRzIHRpbWUgYW5kIHdpbGwgc3RhbmQgZm9yIGFuZXRuaXR5IGFuZCBzZXJ2ZSBhcyBhIHNvdXJjZSBvZiBpbnRlZ3JhdGlvbi4gQ29udmVuYWRlcyB3aWxsIGJlIGJyb2tlbi4gT3VyIHJldHVybiBpcyB0aGUgZ2lmdCBvZiBjaGFvcy4=";
const file2 = "f867490acb2f567b57e7f7b31b81609162e24536717a6a7c4f1c9c4c1a51a1969a53"
// decodifica o Base64
const decoded = Buffer.from(file1, 'base64').toString('utf-8');

console.log("Decodificado:\n", decoded);
const phraseDecoded = " The key will be one before its time and will stand for anetnity and serve as a source of integration. Convenades will be broken. Our return is the gift of chaos."

