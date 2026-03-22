using System.Security.Cryptography;

namespace MoonsecDeobfuscator.Bytecode.Models;

public class Function
{
    public List<Instruction> Instructions = null!;
    public List<Constant> Constants = null!;
    public List<Function> Functions = null!;

    public byte MaxStackSize, NumParams, NumUpvalues, IsVarArgFlag;

    private string? _name;
    public string Name => _name ??= ComputeName();

    private string ComputeName()
    {
        if (Instructions is not { Count: > 0 })
            return $"func_{Guid.NewGuid():N}"[..13];

        var bytes = new byte[Instructions.Count * 4];

        for (var i = 0; i < Instructions.Count; i++)
        {
            var instr = Instructions[i];
            var packed = ((int) instr.OpCode << 24) | ((instr.A & 0xFF) << 16) | ((instr.B & 0xFF) << 8) | (instr.C & 0xFF);
            var offset = i * 4;
            bytes[offset] = (byte) (packed >> 24);
            bytes[offset + 1] = (byte) (packed >> 16);
            bytes[offset + 2] = (byte) (packed >> 8);
            bytes[offset + 3] = (byte) packed;
        }

        var hash = SHA256.HashData(bytes);
        return $"func_{Convert.ToHexString(hash)[..8].ToLower()}";
    }
}