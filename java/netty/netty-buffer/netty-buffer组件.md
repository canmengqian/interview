# 字节缓冲区 ByteBufConvertible

1.  字节缓冲区 ByteBuf
    1.  可交换的字节缓冲区 : SwappedByteBuf
        1.  抽象不安全的缓冲区: AbstractUnsafeSwappedByteBuf
            1. 不安全的堆缓冲区: UnsafeHeapSwappedByteBuf
            2. 不安全的直接缓冲区: UnsafeDirectSwappedByteBuf
    2. 空缓冲区  
    3. 抽象字节缓冲区:  AbstractByteBuf
        1.  抽象派生缓冲区: AbstractDerivedByteBuf
            1.  DuplicatedByteBuf
            2.  ReadOnlyByteBuf
            3.  AbstractUnpooledSlicedByteBuf
    4. 抽象引用计数缓冲区 AbstractReferenceCountedByteBuf
        1.  混合式缓冲区: CompositeByteBuf
            1.  WrappedCompositeByteBuf
            2.  SimpleLeakAwareCompositeByteBuf
            3.   AdvancedLeakAwareCompositeByteBuf
        2.  固定大小的缓冲区: FixedCompositeByteBuf
        3.  非池化直接内存缓冲区 UnpooledDirectByteBuf
            1.  UnpooledUnsafeDirectByteBuf
                1. 非池化不安全无清理器的直接缓冲区 UnpooledUnsafeNoCleanerDirectByteBuf
                2. 非池化不安全的直接缓冲区 WrappedUnpooledUnsafeDirectByteBuf
        4. 池化缓冲区:  PooledByteBuf
            1.   池化堆缓冲区: PooledHeapByteBuf
                1.  PooledUnsafeHeapByteBuf
            2.  池化不安全直接内存缓冲区: PooledUnsafeDirectByteBuf
            3. 池化直接缓冲区:  PooledDirectByteBuf
        5. 只读缓冲区 ReadOnlyByteBufferBuf

# 搜索程序工厂类  SearchProcessorFactory

1.  多路搜索程序工厂:MultiSearchProcessorFactory