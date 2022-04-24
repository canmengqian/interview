[TOC]

# 组件分类

| 编码/解码 组件 | 包名 | 描述 |
| -------------- | ---- | ---- |
| base64         |      |      |
| bytes          |      |      |
| compression    |      |      |
| json           |      |      |
| marshaling     |      |      |
| protobuf       |      |      |
| serialization  |      |      |
| string         |      |      |
| xml            |      |      |

# 组件类

## value转换器

1.  ValueConverter
   1.  CharSequenceValueConverter
   2.  UnsupportedValueConverter

## 字节转消息解码器 ByteToMessageDecoder

1.  ByteToMessageDecoder
   1.   DelimiterBasedFrameDecoder
   2.   FixedLengthFrameDecoder
   3.    LengthFieldBasedFrameDecoder
   4.   ReplayingDecoder
   5.  LineBasedFrameDecoder

## 消息转消息编码器

## 消息转消息解码器

## 消息头

1.  Headers
   1.   DefaultHeaders
      1.   DefaultHeadersImpl
   2.  EmptyHeaders

## 其他