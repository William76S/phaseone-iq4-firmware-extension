// Static, selected-function decompilation. Never executes target firmware.
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.app.cmd.disassemble.DisassembleCommand;
import ghidra.program.model.address.*;
import ghidra.program.model.listing.*;
import ghidra.program.model.symbol.SourceType;
import java.nio.file.*;
import java.util.*;
public class DecompileIQ4 extends GhidraScript {
 public void run() throws Exception {
  String[] args=getScriptArgs();
  byte[] original=Files.readAllBytes(Paths.get(currentProgram.getExecutablePath()));
  String actual=java.util.HexFormat.of().formatHex(java.security.MessageDigest.getInstance("SHA-256").digest(original));
  if(!actual.equals("9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"))throw new IllegalArgumentException("Unknown firmware SHA-256: "+actual);
  Path targets=Paths.get(args[0]);Path out=Paths.get(args[1]);Files.createDirectories(out);
  List<Function> chosen=new ArrayList<>();
  for(String line:Files.readAllLines(targets)){
   if(line.isBlank()||line.startsWith("#"))continue;String[] p=line.split(" ",3);Address a=toAddr(Long.parseUnsignedLong(p[0],16));Address end=toAddr(Long.parseUnsignedLong(p[1],16)-1);AddressSet body=new AddressSet(a,end);
   new DisassembleCommand(a,body,true).applyTo(currentProgram,monitor);
   Function f=getFunctionAt(a);
   if(f==null)f=currentProgram.getFunctionManager().createFunction(p[2],a,body,SourceType.USER_DEFINED);
   else {f.setName(p[2],SourceType.USER_DEFINED);f.setBody(body);}
   chosen.add(f);
  }
  DecompInterface d=new DecompInterface();d.openProgram(currentProgram);
  for(Function f:chosen){
   DecompileResults r=d.decompileFunction(f,30,monitor);
   String text="// INPUT SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb\n// STATIC PSEUDOCODE; recovered types/ABI and flow across tail branches require instruction verification.\n// Linked VA "+f.getEntryPoint()+"\n";
   text+=r.decompileCompleted()?r.getDecompiledFunction().getC():"// ERROR: "+r.getErrorMessage();
   Files.writeString(out.resolve(f.getName()+".c"),text);println("DECOMPILED "+f.getName()+" "+f.getEntryPoint()+" "+r.decompileCompleted());
  }
  d.dispose();
 }
}
