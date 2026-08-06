BigInt checkedU64(BigInt value) {
  if (value.isNegative || value.bitLength > 64) {
    throw RangeError('value must fit in an unsigned 64-bit integer: $value');
  }
  return value;
}

int checkedU64ToNativeInt(BigInt value) =>
    checkedU64(value).toSigned(64).toInt();
