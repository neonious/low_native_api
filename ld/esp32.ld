ENTRY(_start)
SECTIONS
{
  /* Read-only sections, merged into text segment: */
  . = 0;
  .rela.dyn       :
    {
      *(.rela.init)
      *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*)
      *(.rela.fini)
      *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*)
      *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*)
      *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*)
      *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*)
      *(.rela.ctors)
      *(.rela.dtors)
      *(.rela.got)
      *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*)
    }
  .rela.plt       : { *(.rela.plt) }
  /* .plt* sections are embedded in .text */

  /* Exception handling  */
  .eh_frame       : ONLY_IF_RW { KEEP (*(.eh_frame)) }
  . += 0x4;
  .gcc_except_table   : ONLY_IF_RW { *(.gcc_except_table .gcc_except_table.*) }
  /* Thread Local Storage sections  */
  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
  .preinit_array     :
  {
    KEEP (*(.preinit_array))
  }
  .init_array     :
  {
     KEEP (*(SORT(.init_array.*)))
     KEEP (*(.init_array))
  }
  .fini_array     :
  {
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array))
  }
  .ctors          :
  {
    /* gcc uses crtbegin.o to find the start of
       the constructors, so we make sure it is
       first.  Because this is a wildcard, it
       doesn't matter if the user does not
       actually link against crtbegin.o; the
       linker won't look for a file to match a
       wildcard.  The wildcard also means that it
       doesn't matter which directory crtbegin.o
       is in.  */
    KEEP (*crtbegin.o(.ctors))
    KEEP (*crtbegin?.o(.ctors))
    /* We don't want to include the .ctor section from
       the crtend.o file until after the sorted ctors.
       The .ctor section from the crtend file contains the
       end of ctors marker and it must be last */
    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .ctors))
    KEEP (*(SORT(.ctors.*)))
    KEEP (*(.ctors))
  }
  .dtors          :
  {
    KEEP (*crtbegin.o(.dtors))
    KEEP (*crtbegin?.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
  }
  .jcr            : { KEEP (*(.jcr)) }
  .data.rel.ro : { *(.data.rel.ro.local* .gnu.linkonce.d.rel.ro.local.*) *(.data.rel.ro .data.rel.ro.* .gnu.linkonce.d.rel.ro.*) }
  .xt_except_table   : ONLY_IF_RW { KEEP (*(.xt_except_table .xt_except_table.* .gnu.linkonce.e.*)) }
  .dynamic        : { *(.dynamic) }
  .got            : { *(.got) }
  .data           :
  {
    *(.data .data.* .gnu.linkonce.d.*)
    SORT(CONSTRUCTORS)
  }
  .data1          : { *(.data1) }
  .xt_except_desc   :
  {
    *(.xt_except_desc .xt_except_desc.* .gnu.linkonce.h.*)
    *(.xt_except_desc_end)
  }
  .lit4           :
  {
    PROVIDE (_lit4_start = .);
    *(.lit4 .lit4.* .gnu.linkonce.lit4.*)
    PROVIDE (_lit4_end = .);
  }
  _edata = .; PROVIDE (edata = .);
  __bss_start = .;
  .bss            :
  {
   *(.dynbss)
   *(.bss .bss.* .gnu.linkonce.b.*)
   *(COMMON)
   /* Align here to ensure that the .bss section occupies space up to
      _end.  Align after .bss to ensure correct alignment even if the
      .bss section disappears because there are no input sections.
      FIXME: Why do we need it? When there is no .bss section, we don't
      pad the .data section.  */
   . = ALIGN(. != 0 ? 32 / 8 : 1);
  }
  . = ALIGN(32 / 8);
  . = ALIGN(32 / 8);
  _end = .; PROVIDE (end = .);
  .xt.lit       0 : { KEEP (*(.xt.lit .xt.lit.* .gnu.linkonce.p.*)) }
  .xt.insn      0 : { KEEP (*(.xt.insn .gnu.linkonce.x.*)) }
  .xt.prop      0 : { KEEP (*(.xt.prop .xt.prop.* .gnu.linkonce.prop.*)) }
  /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink)  *(.gnu.lto_*) }

  .rodata         : { *(.rodata .rodata.* .gnu.linkonce.r.*) }
  .rodata1        : { *(.rodata1) }
  .got.loc        : { *(.got.loc) }
  .xt_except_table   : ONLY_IF_RO { KEEP (*(.xt_except_table .xt_except_table.* .gnu.linkonce.e.*)) }
  .eh_frame_hdr : { *(.eh_frame_hdr) }
  .eh_frame       : ONLY_IF_RO { KEEP (*(.eh_frame)) }
  . += 0x4;
  .gcc_except_table   : ONLY_IF_RO { *(.gcc_except_table .gcc_except_table.*) }

  /* VADDR1 - SPI RAM */
  . = 0x40000000 - 0x3F800000;

  /* .plt* sections are embedded in .text */
  .text           :
  {
    *(.got.plt* .plt*)
    KEEP (*(.init.literal))
    KEEP (*(SORT_NONE(.init)))
    *(.literal .text .stub .literal.* .text.* .gnu.linkonce.literal.* .gnu.linkonce.t.*.literal .gnu.linkonce.t.*)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
    KEEP (*(.fini.literal))
    KEEP (*(SORT_NONE(.fini)))
  } =0
  PROVIDE (__etext = .);
  PROVIDE (_etext = .);
  PROVIDE (etext = .);
}
