//
// openjpeg.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(*
* The copyright in this software is being made available under the 2-clauses
* BSD License, included below. This software may be subject to other third
* party and contributor rights, including patent rights, and no such rights
* are granted under this license.
*
* Copyright (c) 2002-2014, Universite catholique de Louvain (UCL), Belgium
* Copyright (c) 2002-2014, Professor Benoit Macq
* Copyright (c) 2001-2003, David Janssens
* Copyright (c) 2002-2003, Yannick Verschueren
* Copyright (c) 2003-2007, Francois-Olivier Devaux
* Copyright (c) 2003-2014, Antonin Descampe
* Copyright (c) 2005, Herve Drolon, FreeImage Team
* Copyright (c) 2006-2007, Parvatha Elangovan
* Copyright (c) 2008, Jerome Fimes, Communications & Systemes <jerome.fimes@c-s.fr>
* Copyright (c) 2010-2011, Kaori Hagihara
* Copyright (c) 2011-2012, Centre National d'Etudes Spatiales (CNES), France
* Copyright (c) 2012, CS Systemes d'Information, France
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions
* are met:
* 1. Redistributions of source code must retain the above copyright
*    notice, this list of conditions and the following disclaimer.
* 2. Redistributions in binary form must reproduce the above copyright
*    notice, this list of conditions and the following disclaimer in the
*    documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS `AS IS'
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
* ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
* LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
* SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
* INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
* CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
* ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
* POSSIBILITY OF SUCH DAMAGE.
*)

unit openjpeg;

{$mode objfpc}{$H+}

interface

uses
  ctypes;

const
  LIB_LIBOPENJPEG = 'libopenjp2-7.dll';

// #ifndef OPENJPEG_H
// #define OPENJPEG_H


(*
==========================================================
   Compiler directives
==========================================================
*)

// (*
// The inline keyword is supported by C99 but not by C90.
// Most compilers implement their own version of this keyword ...
// *)
// #ifndef INLINE
// #if defined(_MSC_VER)
// #define INLINE __forceinline
// #elif defined(__GNUC__)
// #define INLINE __inline__
// #elif defined(__MWERKS__)
// #define INLINE inline
// #else
// (* add other compilers here ... *)
// #define INLINE
// #endif (* defined(<Compiler>) *)
// #endif (* INLINE *)

// (* deprecated attribute *)
// #ifdef __GNUC__
// #define OPJ_DEPRECATED(func) func __attribute__ ((deprecated))
// #elif defined(_MSC_VER)
// #define OPJ_DEPRECATED(func) __declspec(deprecated) func
// #else
// #pragma message("WARNING: You need to implement DEPRECATED for this compiler")
// #define OPJ_DEPRECATED(func) func
// #endif

// #if defined(OPJ_STATIC) || !defined(_WIN32)
// (* http://gcc.gnu.org/wiki/Visibility *)
// #   if __GNUC__ >= 4
// #       if defined(OPJ_STATIC) (* static library uses "hidden" *)
// #           define OPJ_API    __attribute__ ((visibility ("hidden")))
// #       else
// #           define OPJ_API    __attribute__ ((visibility ("default")))
// #       endif
// #       define OPJ_LOCAL  __attribute__ ((visibility ("hidden")))
// #   else
// #       define OPJ_API
// #       define OPJ_LOCAL
// #   endif
// #   define OPJ_CALLCONV
// #else
// #   define OPJ_CALLCONV __stdcall
// (*
// The following ifdef block is the standard way of creating macros which make exporting
// from a DLL simpler. All files within this DLL are compiled with the OPJ_EXPORTS
// symbol defined on the command line. this symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see
// OPJ_API functions as being imported from a DLL, whereas this DLL sees symbols
// defined with this macro as being exported.
// *)
// #   if defined(OPJ_EXPORTS) || defined(DLL_EXPORT)
// #       define OPJ_API __declspec(dllexport)
// #   else
// #       define OPJ_API __declspec(dllimport)
// #   endif (* OPJ_EXPORTS *)
// #endif (* !OPJ_STATIC || !_WIN32 *)

type
  POPJ_BOOL = ^OPJ_BOOL;
  OPJ_BOOL = cint;

const
  OPJ_TRUE = 1;
  OPJ_FALSE = 0;

type
  OPJ_CHAR = cchar;
  POPJ_FLOAT32 = ^OPJ_FLOAT32;
  OPJ_FLOAT32 = cfloat;
  OPJ_FLOAT64 = cdouble;
  POPJ_BYTE = ^OPJ_BYTE;
  OPJ_BYTE = cuchar;

{$include opj_stdint.inc}

type
  OPJ_INT8 = int8_t;
  OPJ_UINT8 = uint8_t;
  OPJ_INT16 = int16_t;
  OPJ_UINT16 = uint16_t;
  POPJ_INT32 = ^OPJ_INT32;
  OPJ_INT32 = int32_t;
  POPJ_UINT32 = ^OPJ_UINT32;
  OPJ_UINT32 = uint32_t;
  OPJ_INT64 = int64_t;
  OPJ_UINT64 = uint64_t;

  OPJ_OFF_T = int64_t; (* 64-bit file offset type *)

// #include <stdio.h>
  OPJ_SIZE_T = csize_t;

(* Avoid compile-time warning because parameter is not used *)
//TODO #define OPJ_ARG_NOT_USED(x) (void)(x)

(*
==========================================================
   Useful constant definitions
==========================================================
*)

const
  OPJ_PATH_LEN = 4096; (**< Maximum allowed size for filenames *)

  OPJ_J2K_MAXRLVLS = 33; (**< Number of maximum resolution level authorized *)
  OPJ_J2K_MAXBANDS = (3*OPJ_J2K_MAXRLVLS-2); (**< Number of maximum sub-band linked to number of resolution level *)

  OPJ_J2K_DEFAULT_NB_SEGS = 10;
  OPJ_J2K_STREAM_CHUNK_SIZE = $100000; (** 1 mega by default *)
  OPJ_J2K_DEFAULT_HEADER_SIZE = 1000;
  OPJ_J2K_MCC_DEFAULT_NB_RECORDS = 10;
  OPJ_J2K_MCT_DEFAULT_NB_RECORDS = 10;

(* UniPG>> *) (* NOT YET USED IN THE V2 VERSION OF OPENJPEG *)
  JPWL_MAX_NO_TILESPECS = 16; (**< Maximum number of tile parts expected by JPWL: increase at your will *)
  JPWL_MAX_NO_PACKSPECS = 16; (**< Maximum number of packet parts expected by JPWL: increase at your will *)
  JPWL_MAX_NO_MARKERS = 512; (**< Maximum number of JPWL markers: increase at your will *)
  JPWL_PRIVATEINDEX_NAME = 'jpwl_index_privatefilename'; (**< index file name used when JPWL is on *)
  JPWL_EXPECTED_COMPONENTS = 3; (**< Expect this number of components, so you'll find better the first EPB *)
  JPWL_MAXIMUM_TILES = 8192; (**< Expect this maximum number of tiles, to avoid some crashes *)
  JPWL_MAXIMUM_HAMMING = 2; (**< Expect this maximum number of bit errors in marker id's *)
  JPWL_MAXIMUM_EPB_ROOM = 65450; (**< Expect this maximum number of bytes for composition of EPBs *)
(* <<UniPG *)

(**
 * EXPERIMENTAL FOR THE MOMENT
 * Supported options about file information used only in j2k_dump
*)
  OPJ_IMG_INFO = 1; (**< Basic image information provided to the user *)
  OPJ_J2K_MH_INFO = 2; (**< Codestream information based only on the main header *)
  OPJ_J2K_TH_INFO = 4; (**< Tile information based on the current tile header *)
  OPJ_J2K_TCH_INFO = 8; (**< Tile/Component information of all tiles *)
  OPJ_J2K_MH_IND = 16; (**< Codestream index based only on the main header *)
  OPJ_J2K_TH_IND = 32; (**< Tile index based on the current tile *)
(*FIXME #define OPJ_J2K_CSTR_IND    48*)    (**<  *)
  OPJ_JP2_INFO = 128; (**< JP2 file information *)
  OPJ_JP2_IND = 256; (**< JP2 file index *)

(**
 * JPEG 2000 Profiles, see Table A.10 from 15444-1 (updated in various AMD)
 * These values help choosing the RSIZ value for the J2K codestream.
 * The RSIZ value triggers various encoding options, as detailed in Table A.10.
 * If OPJ_PROFILE_PART2 is chosen, it has to be combined with one or more extensions
 * described hereunder.
 *   Example: rsiz = OPJ_PROFILE_PART2 | OPJ_EXTENSION_MCT;
 * For broadcast profiles, the OPJ_PROFILE value has to be combined with the targeted
 * mainlevel (3-0 LSB, value between 0 and 11):
 *   Example: rsiz = OPJ_PROFILE_BC_MULTI | 0x0005; (here mainlevel 5)
 * For IMF profiles, the OPJ_PROFILE value has to be combined with the targeted mainlevel
 * (3-0 LSB, value between 0 and 11) and sublevel (7-4 LSB, value between 0 and 9):
 *   Example: rsiz = OPJ_PROFILE_IMF_2K | 0x0040 | 0x0005; (here main 5 and sublevel 4)
 * *)
  OPJ_PROFILE_NONE = $0000; (** no profile, conform to 15444-1 *)
  OPJ_PROFILE_0 = $0001; (** Profile 0 as described in 15444-1,Table A.45 *)
  OPJ_PROFILE_1 = $0002; (** Profile 1 as described in 15444-1,Table A.45 *)
  OPJ_PROFILE_PART2 = $8000; (** At least 1 extension defined in 15444-2 (Part-2) *)
  OPJ_PROFILE_CINEMA_2K = $0003; (** 2K cinema profile defined in 15444-1 AMD1 *)
  OPJ_PROFILE_CINEMA_4K = $0004; (** 4K cinema profile defined in 15444-1 AMD1 *)
  OPJ_PROFILE_CINEMA_S2K = $0005; (** Scalable 2K cinema profile defined in 15444-1 AMD2 *)
  OPJ_PROFILE_CINEMA_S4K = $0006; (** Scalable 4K cinema profile defined in 15444-1 AMD2 *)
  OPJ_PROFILE_CINEMA_LTS = $0007; (** Long term storage cinema profile defined in 15444-1 AMD2 *)
  OPJ_PROFILE_BC_SINGLE = $0100; (** Single Tile Broadcast profile defined in 15444-1 AMD3 *)
  OPJ_PROFILE_BC_MULTI = $0200; (** Multi Tile Broadcast profile defined in 15444-1 AMD3 *)
  OPJ_PROFILE_BC_MULTI_R = $0300; (** Multi Tile Reversible Broadcast profile defined in 15444-1 AMD3 *)
  OPJ_PROFILE_IMF_2K = $0400; (** 2K Single Tile Lossy IMF profile defined in 15444-1 AMD 8 *)
  OPJ_PROFILE_IMF_4K = $0401; (** 4K Single Tile Lossy IMF profile defined in 15444-1 AMD 8 *)
  OPJ_PROFILE_IMF_8K = $0402; (** 8K Single Tile Lossy IMF profile defined in 15444-1 AMD 8 *)
  OPJ_PROFILE_IMF_2K_R = $0403; (** 2K Single/Multi Tile Reversible IMF profile defined in 15444-1 AMD 8 *)
  OPJ_PROFILE_IMF_4K_R = $0800; (** 4K Single/Multi Tile Reversible IMF profile defined in 15444-1 AMD 8 *)
  OPJ_PROFILE_IMF_8K_R = $0801; (** 8K Single/Multi Tile Reversible IMF profile defined in 15444-1 AMD 8 *)

(**
 * JPEG 2000 Part-2 extensions
 * *)
  OPJ_EXTENSION_NONE = $0000; (** No Part-2 extension *)
  OPJ_EXTENSION_MCT = $0100; (** Custom MCT support *)

(**
 * JPEG 2000 profile macros
 * *)
//TODO #define OPJ_IS_CINEMA(v)     (((v) >= OPJ_PROFILE_CINEMA_2K)&&((v) <= OPJ_PROFILE_CINEMA_S4K))
//TODO #define OPJ_IS_STORAGE(v)    ((v) == OPJ_PROFILE_CINEMA_LTS)
//TODO #define OPJ_IS_BROADCAST(v)  (((v) >= OPJ_PROFILE_BC_SINGLE)&&((v) <= ((OPJ_PROFILE_BC_MULTI_R) | (0x000b))))
//TODO #define OPJ_IS_IMF(v)        (((v) >= OPJ_PROFILE_IMF_2K)&&((v) <= ((OPJ_PROFILE_IMF_8K_R) | (0x009b))))
//TODO #define OPJ_IS_PART2(v)      ((v) & OPJ_PROFILE_PART2)

(**
 * JPEG 2000 codestream and component size limits in cinema profiles
 * *)
  OPJ_CINEMA_24_CS = 1302083; (** Maximum codestream length for 24fps *)
  OPJ_CINEMA_48_CS = 651041; (** Maximum codestream length for 48fps *)
  OPJ_CINEMA_24_COMP = 1041666; (** Maximum size per color component for 2K & 4K @ 24fps *)
  OPJ_CINEMA_48_COMP = 520833; (** Maximum size per color component for 2K @ 48fps *)

(*
==========================================================
   enum definitions
==========================================================
*)

(**
 * DEPRECATED: use RSIZ, OPJ_PROFILE_* and OPJ_EXTENSION_* instead
 * Rsiz Capabilities
 * *)
type
  OPJ_RSIZ_CAPABILITIES = (
    OPJ_STD_RSIZ = 0, (** Standard JPEG2000 profile*)
    OPJ_CINEMA2K = 3, (** Profile name for a 2K image*)
    OPJ_CINEMA4K = 4, (** Profile name for a 4K image*)
    OPJ_MCT = $8100
  );

(**
 * DEPRECATED: use RSIZ, OPJ_PROFILE_* and OPJ_EXTENSION_* instead
 * Digital cinema operation mode
 * *)
  OPJ_CINEMA_MODE = (
    OPJ_OFF = 0, (** Not Digital Cinema*)
    OPJ_CINEMA2K_24 = 1, (** 2K Digital Cinema at 24 fps*)
    OPJ_CINEMA2K_48 = 2, (** 2K Digital Cinema at 48 fps*)
    OPJ_CINEMA4K_24 = 3 (** 4K Digital Cinema at 24 fps*)
  );

(**
 * Progression order
 * *)
  OPJ_PROG_ORDER = (
    OPJ_PROG_UNKNOWN = -1, (**< place-holder *)
    OPJ_LRCP = 0, (**< layer-resolution-component-precinct order *)
    OPJ_RLCP = 1, (**< resolution-layer-component-precinct order *)
    OPJ_RPCL = 2, (**< resolution-precinct-component-layer order *)
    OPJ_PCRL = 3, (**< precinct-component-resolution-layer order *)
    OPJ_CPRL = 4 (**< component-precinct-resolution-layer order *)
  );

(**
 * Supported image color spaces
*)
  OPJ_COLOR_SPACE = (
    OPJ_CLRSPC_UNKNOWN = -1, (**< not supported by the library *)
    OPJ_CLRSPC_UNSPECIFIED = 0, (**< not specified in the codestream *)
    OPJ_CLRSPC_SRGB = 1, (**< sRGB *)
    OPJ_CLRSPC_GRAY = 2, (**< grayscale *)
    OPJ_CLRSPC_SYCC = 3, (**< YUV *)
    OPJ_CLRSPC_EYCC = 4, (**< e-YCC *)
    OPJ_CLRSPC_CMYK = 5 (**< CMYK *)
  );

(**
 * Supported codec
*)
  OPJ_CODEC_FORMAT = (
    OPJ_CODEC_UNKNOWN = -1, (**< place-holder *)
    OPJ_CODEC_J2K  = 0, (**< JPEG-2000 codestream : read/write *)
    OPJ_CODEC_JPT  = 1, (**< JPT-stream (JPEG 2000, JPIP) : read only *)
    OPJ_CODEC_JP2  = 2, (**< JP2 file format : read/write *)
    OPJ_CODEC_JPP  = 3, (**< JPP-stream (JPEG 2000, JPIP) : to be coded *)
    OPJ_CODEC_JPX  = 4 (**< JPX file format (JPEG 2000 Part-2) : to be coded *)
  );


(*
==========================================================
   event manager typedef definitions
==========================================================
*)

(**
 * Callback function prototype for events
 * @param msg               Event message
 * @param client_data       Client object where will be return the event message
 * *)
  opj_msg_callback = procedure (const msg: pchar; client_data: pointer); cdecl;

(*
==========================================================
   codec typedef definitions
==========================================================
*)

(**
 * Progression order changes
 *
 *)
  opj_poc_t = record
    (** Resolution num start, Component num start, given by POC *)
    resno0, compno0: OPJ_UINT32;
    (** Layer num end,Resolution num end, Component num end, given by POC *)
    layno1, resno1, compno1: OPJ_UINT32;
    (** Layer num start,Precinct num start, Precinct num end *)
    layno0, precno0, precno1: OPJ_UINT32;
    (** Progression order enum*)
    prg1, prg: OPJ_PROG_ORDER;
    (** Progression order string*)
    progorder: array[0..4] of OPJ_CHAR;
    (** Tile number *)
    tile: OPJ_UINT32;
    (** Start and end values for Tile width and height*)
    tx0, tx1, ty0, ty1: OPJ_INT32;
    (** Start value, initialised in pi_initialise_encode*)
    layS, resS, compS, prcS: OPJ_UINT32;
    (** End value, initialised in pi_initialise_encode *)
    layE, resE, compE, prcE: OPJ_UINT32;
    (** Start and end values of Tile width and height, initialised in pi_initialise_encode*)
    txS, txE, tyS, tyE, dx, dy: OPJ_UINT32;
    (** Temporary values for Tile parts, initialised in pi_create_encode *)
    lay_t, res_t, comp_t, prc_t, tx0_t, ty0_t: OPJ_UINT32;
  end;

(**
 * Compression parameters
 * *)
  Popj_cparameters_t = ^opj_cparameters_t;
  opj_cparameters_t = record
    (** size of tile: tile_size_on = false (not in argument) or = true (in argument) *)
    tile_size_on: OPJ_BOOL;
    (** XTOsiz *)
    cp_tx0: cint;
    (** YTOsiz *)
    cp_ty0: cint;
    (** XTsiz *)
    cp_tdx: cint;
    (** YTsiz *)
    cp_tdy: cint;
    (** allocation by rate/distortion *)
    cp_disto_alloc: cint;
    (** allocation by fixed layer *)
    cp_fixed_alloc: cint;
    (** add fixed_quality *)
    cp_fixed_quality: cint;
    (** fixed layer *)
    cp_matrice: pcint;
    (** comment for coding *)
    cp_comment: pchar;
    (** csty : coding style *)
    csty: cint;
    (** progression order (default OPJ_LRCP) *)
    prog_order: OPJ_PROG_ORDER;
    (** progression order changes *)
    POC: array[0..31] of opj_poc_t;
    (** number of progression order changes (POC), default to 0 *)
    numpocs: OPJ_UINT32;
    (** number of layers *)
    tcp_numlayers: cint;
    (** rates of layers - might be subsequently limited by the max_cs_size field *)
    tcp_rates: array[0..99] of cfloat;
    (** different psnr for successive layers *)
    tcp_distoratio: array[0..99] of cfloat;
    (** number of resolutions *)
    numresolution: cint;
    (** initial code block width, default to 64 *)
    cblockw_init: cint;
    (** initial code block height, default to 64 *)
    cblockh_init: cint;
    (** mode switch (cblk_style) *)
    mode: cint;
    (** 1 : use the irreversible DWT 9-7, 0 : use lossless compression (default) *)
    irreversible: cint;
    (** region of interest: affected component in [0..3], -1 means no ROI *)
    roi_compno: cint;
    (** region of interest: upshift value *)
    roi_shift: cint;
    (* number of precinct size specifications *)
    res_spec: cint;
    (** initial precinct width *)
    prcw_init: array[0..OPJ_J2K_MAXRLVLS-1] of cint;
    (** initial precinct height *)
    prch_init: array[0..OPJ_J2K_MAXRLVLS-1] of cint;

    (**@name command line encoder parameters (not used inside the library) *)
    (*@{*)
    (** input file name *)
    infile: array[0..OPJ_PATH_LEN-1] of char;
    (** output file name *)
    outfile: array[0..OPJ_PATH_LEN-1] of char;
    (** DEPRECATED. Index generation is now handeld with the opj_encode_with_info() function. Set to NULL *)
    index_on: cint;
    (** DEPRECATED. Index generation is now handeld with the opj_encode_with_info() function. Set to NULL *)
    index: array[0..OPJ_PATH_LEN-1] of char;
    (** subimage encoding: origin image offset in x direction *)
    image_offset_x0: cint;
    (** subimage encoding: origin image offset in y direction *)
    image_offset_y0: cint;
    (** subsampling value for dx *)
    subsampling_dx: cint;
    (** subsampling value for dy *)
    subsampling_dy: cint;
    (** input file format 0: PGX, 1: PxM, 2: BMP 3:TIF*)
    decod_format: cint;
    (** output file format 0: J2K, 1: JP2, 2: JPT *)
    cod_format: cint;
    (*@}*)

    (* UniPG>> *) (* NOT YET USED IN THE V2 VERSION OF OPENJPEG *)
    (**@name JPWL encoding parameters *)
    (*@{*)
    (** enables writing of EPC in MH, thus activating JPWL *)
    jpwl_epc_on: OPJ_BOOL;
    (** error protection method for MH (0,1,16,32,37-128) *)
    jpwl_hprot_MH: cint;
    (** tile number of header protection specification (>=0) *)
    jpwl_hprot_TPH_tileno: array[0..JPWL_MAX_NO_TILESPECS-1] of cint;
    (** error protection methods for TPHs (0,1,16,32,37-128) *)
    jpwl_hprot_TPH: array[0..JPWL_MAX_NO_TILESPECS-1] of cint;
    (** tile number of packet protection specification (>=0) *)
    jpwl_pprot_tileno: array[0..JPWL_MAX_NO_PACKSPECS-1] of cint;
    (** packet number of packet protection specification (>=0) *)
    jpwl_pprot_packno: array[0..JPWL_MAX_NO_PACKSPECS-1] of cint;
    (** error protection methods for packets (0,1,16,32,37-128) *)
    jpwl_pprot: array[0..JPWL_MAX_NO_PACKSPECS-1] of cint;
    (** enables writing of ESD, (0=no/1/2 bytes) *)
    jpwl_sens_size: cint;
    (** sensitivity addressing size (0=auto/2/4 bytes) *)
    jpwl_sens_addr: cint;
    (** sensitivity range (0-3) *)
    jpwl_sens_range: cint;
    (** sensitivity method for MH (-1=no,0-7) *)
    jpwl_sens_MH: cint;
    (** tile number of sensitivity specification (>=0) *)
    jpwl_sens_TPH_tileno: array[0..JPWL_MAX_NO_TILESPECS-1] of cint;
    (** sensitivity methods for TPHs (-1=no,0-7) *)
    jpwl_sens_TPH: array[0..JPWL_MAX_NO_TILESPECS-1] of cint;
    (*@}*)
    (* <<UniPG *)

    (**
     * DEPRECATED: use RSIZ, OPJ_PROFILE_* and MAX_COMP_SIZE instead
     * Digital Cinema compliance 0-not compliant, 1-compliant
     * *)
    cp_cinema: OPJ_CINEMA_MODE;
    (**
     * Maximum size (in bytes) for each component.
     * If == 0, component size limitation is not considered
     * *)
    max_comp_size: cint;
    (**
     * DEPRECATED: use RSIZ, OPJ_PROFILE_* and OPJ_EXTENSION_* instead
     * Profile name
     * *)
    cp_rsiz: OPJ_RSIZ_CAPABILITIES;
    (** Tile part generation*)
    tp_on: char;
    (** Flag for Tile part generation*)
    tp_flag: char;
    (** MCT (multiple component transform) *)
    tcp_mct: char;
    (** Enable JPIP indexing*)
    jpip_on: OPJ_BOOL;
    (** Naive implementation of MCT restricted to a single reversible array based
        encoding without offset concerning all the components. *)
    mct_data: pointer;
    (**
     * Maximum size (in bytes) for the whole codestream.
     * If == 0, codestream size limitation is not considered
     * If it does not comply with tcp_rates, max_cs_size prevails
     * and a warning is issued.
     * *)
    max_cs_size: cint;
    (** RSIZ value
        To be used to combine OPJ_PROFILE_*, OPJ_EXTENSION_* and (sub)levels values. *)
    rsiz: OPJ_UINT16;
  end;

const
  OPJ_DPARAMETERS_IGNORE_PCLR_CMAP_CDEF_FLAG = $0001;
  OPJ_DPARAMETERS_DUMP_FLAG = $0002;

(**
 * Decompression parameters
 * *)
type
  Popj_dparameters_t = ^opj_dparameters_t;
  opj_dparameters_t = record
    (**
    Set the number of highest resolution levels to be discarded.
    The image resolution is effectively divided by 2 to the power of the number of discarded levels.
    The reduce factor is limited by the smallest total number of decomposition levels among tiles.
    if != 0, then original dimension divided by 2^(reduce);
    if == 0 or not used, image is decoded to the full resolution
    *)
    cp_reduce: OPJ_UINT32;
    (**
    Set the maximum number of quality layers to decode.
    If there are less quality layers than the specified number, all the quality layers are decoded.
    if != 0, then only the first "layer" layers are decoded;
    if == 0 or not used, all the quality layers are decoded
    *)
    cp_layer: OPJ_UINT32;

    (**@name command line decoder parameters (not used inside the library) *)
    (*@{*)
    (** input file name *)
    infile: array[0..OPJ_PATH_LEN-1] of char;
    (** output file name *)
    outfile: array[0..OPJ_PATH_LEN-1] of char;
    (** input file format 0: J2K, 1: JP2, 2: JPT *)
    decod_format: cint;
    (** output file format 0: PGX, 1: PxM, 2: BMP *)
    cod_format: cint;

    (** Decoding area left boundary *)
    DA_x0: OPJ_UINT32;
    (** Decoding area right boundary *)
    DA_x1: OPJ_UINT32;
    (** Decoding area up boundary *)
    DA_y0: OPJ_UINT32;
    (** Decoding area bottom boundary *)
    DA_y1: OPJ_UINT32;
    (** Verbose mode *)
    m_verbose: OPJ_BOOL;

    (** tile number ot the decoded tile*)
    tile_index: OPJ_UINT32;
    (** Nb of tile to decode *)
    nb_tile_to_decode: OPJ_UINT32;

    (*@}*)

    (* UniPG>> *) (* NOT YET USED IN THE V2 VERSION OF OPENJPEG *)
    (**@name JPWL decoding parameters *)
    (*@{*)
    (** activates the JPWL correction capabilities *)
    jpwl_correct: OPJ_BOOL;
    (** expected number of components *)
    jpwl_exp_comps: cint;
    (** maximum number of tiles *)
    jpwl_max_tiles: cint;
    (*@}*)
    (* <<UniPG *)

    flags: cuint;
  end;


(**
 * JPEG2000 codec V2.
 * *)
type
  Popj_codec_t = ^opj_codec_t;
  opj_codec_t = pointer;

(*
==========================================================
   I/O stream typedef definitions
==========================================================
*)

(**
 * Stream open flags.
 * *)
const
(** The stream was opened for reading. *)
  OPJ_STREAM_READ = OPJ_TRUE;
(** The stream was opened for writing. *)
  OPJ_STREAM_WRITE = OPJ_FALSE;

(*
 * Callback function prototype for read function
 *)
type
  opj_stream_read_fn = function (p_buffer: pointer; p_nb_bytes: OPJ_SIZE_T; p_user_data: pointer): OPJ_SIZE_T; cdecl;

(*
 * Callback function prototype for write function
 *)
type
  opj_stream_write_fn = function (p_buffer: pointer; p_nb_bytes: OPJ_SIZE_T; p_user_data: pointer): OPJ_SIZE_T; cdecl;

(*
 * Callback function prototype for skip function
 *)
type
  opj_stream_skip_fn = function (p_nb_bytes: OPJ_OFF_T; p_user_data: pointer): OPJ_OFF_T; cdecl;

(*
 * Callback function prototype for seek function
 *)
type
  opj_stream_seek_fn = function (p_nb_bytes: OPJ_OFF_T; p_user_data: pointer): OPJ_BOOL; cdecl;

(*
 * Callback function prototype for free user data function
 *)
type
  opj_stream_free_user_data_fn = procedure (p_user_data: pointer); cdecl;

(*
 * JPEG2000 Stream.
 *)
type
  Popj_stream_t = ^opj_stream_t;
  opj_stream_t = pointer;

(*
==========================================================
   image typedef definitions
==========================================================
*)

(**
 * Defines a single image component
 * *)
type
  Popj_image_comp_t = ^opj_image_comp_t;
  opj_image_comp_t = record
    (** XRsiz: horizontal separation of a sample of ith component with respect to the reference grid *)
    dx: OPJ_UINT32;
    (** YRsiz: vertical separation of a sample of ith component with respect to the reference grid *)
    dy: OPJ_UINT32;
    (** data width *)
    w: OPJ_UINT32;
    (** data height *)
    h: OPJ_UINT32;
    (** x component offset compared to the whole image *)
    x0: OPJ_UINT32;
    (** y component offset compared to the whole image *)
    y0: OPJ_UINT32;
    (** precision *)
    prec: OPJ_UINT32;
    (** image depth in bits *)
    bpp: OPJ_UINT32;
    (** signed (1) / unsigned (0) *)
    sgnd: OPJ_UINT32;
    (** number of decoded resolution *)
    resno_decoded: OPJ_UINT32;
    (** number of division by 2 of the out image compared to the original size of image *)
    factor: OPJ_UINT32;
    (** image component data *)
    data: POPJ_INT32;
    (** alpha channel *)
    alpha: OPJ_UINT16;
  end;

(**
 * Defines image data and characteristics
 * *)
  PPopj_image_t = ^Popj_image_t;
  Popj_image_t = ^opj_image_t;
  opj_image_t = record
    (** XOsiz: horizontal offset from the origin of the reference grid to the left side of the image area *)
    x0: OPJ_UINT32;
    (** YOsiz: vertical offset from the origin of the reference grid to the top side of the image area *)
    y0: OPJ_UINT32;
    (** Xsiz: width of the reference grid *)
    x1: OPJ_UINT32;
    (** Ysiz: height of the reference grid *)
    y1: OPJ_UINT32;
    (** number of components in the image *)
    numcomps: OPJ_UINT32;
    (** color space: sRGB, Greyscale or YUV *)
    color_space: OPJ_COLOR_SPACE;
    (** image components *)
    comps: Popj_image_comp_t;
    (** 'restricted' ICC profile *)
    icc_profile_buf: POPJ_BYTE;
    (** size of ICC profile *)
    icc_profile_len: OPJ_UINT32;
  end;


(**
 * Component parameters structure used by the opj_image_create function
 * *)
  Popj_image_cmptparm_t = ^opj_image_cmptparm_t;
  opj_image_cmptparm_t = record
    (** XRsiz: horizontal separation of a sample of ith component with respect to the reference grid *)
    dx: OPJ_UINT32;
    (** YRsiz: vertical separation of a sample of ith component with respect to the reference grid *)
    dy: OPJ_UINT32;
    (** data width *)
    w: OPJ_UINT32;
    (** data height *)
    h: OPJ_UINT32;
    (** x component offset compared to the whole image *)
    x0: OPJ_UINT32;
    (** y component offset compared to the whole image *)
    y0: OPJ_UINT32;
    (** precision *)
    prec: OPJ_UINT32;
    (** image depth in bits *)
    bpp: OPJ_UINT32;
    (** signed (1) / unsigned (0) *)
    sgnd: OPJ_UINT32;
  end;


(*
==========================================================
   Information on the JPEG 2000 codestream
==========================================================
*)
(* QUITE EXPERIMENTAL FOR THE MOMENT *)

(**
 * Index structure : Information concerning a packet inside tile
 * *)
  Popj_packet_info_t = ^opj_packet_info_t;
  opj_packet_info_t = record
    (** packet start position (including SOP marker if it exists) *)
    start_pos: OPJ_OFF_T;
    (** end of packet header position (including EPH marker if it exists)*)
    end_ph_pos: OPJ_OFF_T;
    (** packet end position *)
    end_pos: OPJ_OFF_T;
    (** packet distorsion *)
    disto: cdouble;
  end;


(* UniPG>> *)
(**
 * Marker structure
 * *)
  Popj_marker_info_t = ^opj_marker_info_t;
  opj_marker_info_t = record
    (** marker type *)
    type_: cushort;
    (** position in codestream *)
    pos: OPJ_OFF_T;
    (** length, marker val included *)
    len: cint;
  end;
(* <<UniPG *)

(**
 * Index structure : Information concerning tile-parts
*)
  Popj_tp_info_t = ^opj_tp_info_t;
  opj_tp_info_t = record
    (** start position of tile part *)
    tp_start_pos: cint;
    (** end position of tile part header *)
    tp_end_header: cint;
    (** end position of tile part *)
    tp_end_pos: cint;
    (** start packet of tile part *)
    tp_start_pack: cint;
    (** number of packets of tile part *)
    tp_numpacks: cint;
  end;

(**
 * Index structure : information regarding tiles
*)
  Popj_tile_info_t = ^opj_tile_info_t;
  opj_tile_info_t = record
    (** value of thresh for each layer by tile cfr. Marcela   *)
    thresh: pcdouble;
    (** number of tile *)
    tileno: cint;
    (** start position *)
    start_pos: cint;
    (** end position of the header *)
    end_header: cint;
    (** end position *)
    end_pos: cint;
    (** precinct number for each resolution level (width) *)
    pw: array[0..32] of cint;
    (** precinct number for each resolution level (height) *)
    ph: array[0..32] of cint;
    (** precinct size (in power of 2), in X for each resolution level *)
    pdx: array[0..32] of cint;
    (** precinct size (in power of 2), in Y for each resolution level *)
    pdy: array[0..32] of cint;
    (** information concerning packets inside tile *)
    packet: Popj_packet_info_t;
    (** add fixed_quality *)
    numpix: cint;
    (** add fixed_quality *)
    distotile: cdouble;
    (** number of markers *)
    marknum: cint;
    (** list of markers *)
    marker: Popj_marker_info_t;
    (** actual size of markers array *)
    maxmarknum: cint;
    (** number of tile parts *)
    num_tps: cint;
    (** information concerning tile parts *)
    tp: Popj_tp_info_t;
  end;

(**
 * Index structure of the codestream
*)
  opj_codestream_info_t = record
    (** maximum distortion reduction on the whole image (add for Marcela) *)
    D_max: cdouble;
    (** packet number *)
    packno: cint;
    (** writing the packet in the index with t2_encode_packets *)
    index_write: cint;
    (** image width *)
    image_w: cint;
    (** image height *)
    image_h: cint;
    (** progression order *)
    prog: OPJ_PROG_ORDER;
    (** tile size in x *)
    tile_x: cint;
    (** tile size in y *)
    tile_y: cint;
    (** *)
    tile_Ox: cint;
    (** *)
    tile_Oy: cint;
    (** number of tiles in X *)
    tw: cint;
    (** number of tiles in Y *)
    th: cint;
    (** component numbers *)
    numcomps: cint;
    (** number of layer *)
    numlayers: cint;
    (** number of decomposition for each component *)
    numdecompos: pcint;
    (* UniPG>> *)
    (** number of markers *)
    marknum: cint;
    (** list of markers *)
    marker: Popj_marker_info_t;
    (** actual size of markers array *)
    maxmarknum: cint;
    (* <<UniPG *)
    (** main header position *)
    main_head_start: cint;
    (** main header position *)
    main_head_end: cint;
    (** codestream's size *)
    codestream_size: cint;
    (** information regarding tiles inside image *)
    tile: Popj_tile_info_t;
  end;

(* <----------------------------------------------------------- *)
(* new output management of the codestream information and index *)

(**
 * Tile-component coding parameters information
 *)
  Popj_tccp_info_t = ^opj_tccp_info_t;
  opj_tccp_info_t = record
    (** component index *)
    compno: OPJ_UINT32;
    (** coding style *)
    csty: OPJ_UINT32;
    (** number of resolutions *)
    numresolutions: OPJ_UINT32;
    (** code-blocks width *)
    cblkw: OPJ_UINT32;
    (** code-blocks height *)
    cblkh: OPJ_UINT32;
    (** code-block coding style *)
    cblksty: OPJ_UINT32;
    (** discrete wavelet transform identifier: 0 = 9-7 irreversible, 1 = 5-3 reversible *)
    qmfbid: OPJ_UINT32;
    (** quantisation style *)
    qntsty: OPJ_UINT32;
    (** stepsizes used for quantization *)
    stepsizes_mant: array[0..OPJ_J2K_MAXBANDS-1] of OPJ_UINT32;
    (** stepsizes used for quantization *)
    stepsizes_expn: array[0..OPJ_J2K_MAXBANDS-1] of OPJ_UINT32;
    (** number of guard bits *)
    numgbits: OPJ_UINT32;
    (** Region Of Interest shift *)
    roishift: OPJ_INT32;
    (** precinct width *)
    prcw: array[0..OPJ_J2K_MAXRLVLS-1] of OPJ_UINT32;
    (** precinct height *)
    prch: array[0..OPJ_J2K_MAXRLVLS-1] of OPJ_UINT32;
  end;

(**
 * Tile coding parameters information
 *)
  Popj_tile_info_v2_t = ^opj_tile_info_v2_t;
  opj_tile_info_v2_t = record
    (** number (index) of tile *)
    tileno: cint;
    (** coding style *)
    csty: OPJ_UINT32;
    (** progression order *)
    prg: OPJ_PROG_ORDER;
    (** number of layers *)
    numlayers: OPJ_UINT32;
    (** multi-component transform identifier *)
    mct: OPJ_UINT32;

    (** information concerning tile component parameters*)
    tccp_info: Popj_tccp_info_t;
  end;

(**
 * Information structure about the codestream (FIXME should be expand and enhance)
 *)
  PPopj_codestream_info_v2_t = ^Popj_codestream_info_v2_t;
  Popj_codestream_info_v2_t = ^opj_codestream_info_v2_t;
  opj_codestream_info_v2_t = record
    (* Tile info *)
    (** tile origin in x = XTOsiz *)
    tx0: OPJ_UINT32;
    (** tile origin in y = YTOsiz *)
    ty0: OPJ_UINT32;
    (** tile size in x = XTsiz *)
    tdx: OPJ_UINT32;
    (** tile size in y = YTsiz *)
    tdy: OPJ_UINT32;
    (** number of tiles in X *)
    tw: OPJ_UINT32;
    (** number of tiles in Y *)
    th: OPJ_UINT32;

    (** number of components*)
    nbcomps: OPJ_UINT32;

    (** Default information regarding tiles inside image *)
    m_default_tile_info: opj_tile_info_v2_t;

    (** information regarding tiles inside image *)
    tile_info: Popj_tile_info_v2_t; (* FIXME not used for the moment *)
  end;


(**
 * Index structure about a tile part
 *)
  Popj_tp_index_t = ^opj_tp_index_t;
  opj_tp_index_t = record
    (** start position *)
    start_pos: OPJ_OFF_T;
    (** end position of the header *)
    end_header: OPJ_OFF_T;
    (** end position *)
    end_pos: OPJ_OFF_T;
  end;

(**
 * Index structure about a tile
 *)
  Popj_tile_index_t = ^opj_tile_index_t;
  opj_tile_index_t = record
    (** tile index *)
    tileno: OPJ_UINT32;

    (** number of tile parts *)
    nb_tps: OPJ_UINT32;
    (** current nb of tile part (allocated)*)
    current_nb_tps: OPJ_UINT32;
    (** current tile-part index *)
    current_tpsno: OPJ_UINT32;
    (** information concerning tile parts *)
    tp_index: Popj_tp_index_t;

    (* UniPG>> *) (* NOT USED FOR THE MOMENT IN THE V2 VERSION *)
    (** number of markers *)
    marknum: OPJ_UINT32;
    (** list of markers *)
    marker: Popj_marker_info_t;
    (** actual size of markers array *)
    maxmarknum: OPJ_UINT32;
    (* <<UniPG *)

    (** packet number *)
    nb_packet: OPJ_UINT32;
    (** information concerning packets inside tile *)
    packet_index: Popj_packet_info_t;
  end;

(**
 * Index structure of the codestream (FIXME should be expand and enhance)
 *)
  PPopj_codestream_index_t = ^Popj_codestream_index_t;
  Popj_codestream_index_t = ^opj_codestream_index_t;
  opj_codestream_index_t = record
    (** main header start position (SOC position) *)
    main_head_start: OPJ_OFF_T;
    (** main header end position (first SOT position) *)
    main_head_end: OPJ_OFF_T;

    (** codestream's size *)
    codestream_size: OPJ_UINT64;

    (* UniPG>> *) (* NOT USED FOR THE MOMENT IN THE V2 VERSION *)
    (** number of markers *)
    marknum: OPJ_UINT32;
    (** list of markers *)
    marker: Popj_marker_info_t;
    (** actual size of markers array *)
    maxmarknum: OPJ_UINT32;
    (* <<UniPG *)

    (** *)
    nb_of_tiles: OPJ_UINT32;
    (** *)
    tile_index: Popj_tile_index_t; (* FIXME not used for the moment *)
  end;

(* -----------------------------------------------------------> *)

(*
==========================================================
   Metadata from the JP2file
==========================================================
*)

(**
 * Info structure of the JP2 file
 * EXPERIMENTAL FOR THE MOMENT
 *)
  Popj_jp2_metadata_t = ^opj_jp2_metadata_t;
  opj_jp2_metadata_t = record
    (** *)
    not_used: OPJ_INT32;
  end;

(**
 * Index structure of the JP2 file
 * EXPERIMENTAL FOR THE MOMENT
 *)
  Popj_jp2_index_t = ^opj_jp2_index_t;
  opj_jp2_index_t = record
    (** *)
    not_used: OPJ_INT32;
  end;


// #ifdef __cplusplus
// extern "C" {
// #endif


(*
==========================================================
   openjpeg version
==========================================================
*)

(* Get the version of the openjpeg library*)
function opj_version(): pchar; cdecl; external LIB_LIBOPENJPEG;

(*
==========================================================
   image functions definitions
==========================================================
*)

(**
 * Create an image
 *
 * @param numcmpts      number of components
 * @param cmptparms     components parameters
 * @param clrspc        image color space
 * @return returns      a new image structure if successful, returns NULL otherwise
 * *)
function opj_image_create(numcmpts: OPJ_UINT32; cmptparms: Popj_image_cmptparm_t; clrspc: OPJ_COLOR_SPACE): Popj_image_t; cdecl; external LIB_LIBOPENJPEG;

(**
 * Deallocate any resources associated with an image
 *
 * @param image         image to be destroyed
 *)
procedure opj_image_destroy(image: Popj_image_t); cdecl; external LIB_LIBOPENJPEG;

(**
 * Creates an image without allocating memory for the image (used in the new version of the library).
 *
 * @param   numcmpts    the number of components
 * @param   cmptparms   the components parameters
 * @param   clrspc      the image color space
 *
 * @return  a new image structure if successful, NULL otherwise.
*)
function opj_image_tile_create(numcmpts: OPJ_UINT32; cmptparms: Popj_image_cmptparm_t; clrspc: OPJ_COLOR_SPACE): Popj_image_t; cdecl; external LIB_LIBOPENJPEG;

(**
 * Allocator for opj_image_t->comps[].data
 * To be paired with opj_image_data_free.
 *
 * @param   size    number of bytes to allocate
 *
 * @return  a new pointer if successful, NULL otherwise.
 * @since 2.2.0
*)
function opj_image_data_alloc(size: OPJ_SIZE_T): pointer; cdecl; external LIB_LIBOPENJPEG;

(**
 * Destructor for opj_image_t->comps[].data
 * To be paired with opj_image_data_alloc.
 *
 * @param   ptr    Pointer to free
 *
 * @since 2.2.0
*)
procedure opj_image_data_free(ptr: pointer); cdecl; external LIB_LIBOPENJPEG;

(*
==========================================================
   stream functions definitions
==========================================================
*)

(**
 * Creates an abstract stream. This function does nothing except allocating memory and initializing the abstract stream.
 *
 * @param   p_is_input      if set to true then the stream will be an input stream, an output stream else.
 *
 * @return  a stream object.
*)
function opj_stream_default_create(p_is_input: OPJ_BOOL): Popj_stream_t; cdecl; external LIB_LIBOPENJPEG;

(**
 * Creates an abstract stream. This function does nothing except allocating memory and initializing the abstract stream.
 *
 * @param   p_buffer_size  FIXME DOC
 * @param   p_is_input      if set to true then the stream will be an input stream, an output stream else.
 *
 * @return  a stream object.
*)
function opj_stream_create(p_buffer_size: OPJ_SIZE_T; p_is_input: OPJ_BOOL): Popj_stream_t; cdecl; external LIB_LIBOPENJPEG;

(**
 * Destroys a stream created by opj_create_stream. This function does NOT close the abstract stream. If needed the user must
 * close its own implementation of the stream.
 *
 * @param   p_stream    the stream to destroy.
 *)
procedure opj_stream_destroy(p_stream: Popj_stream_t); cdecl; external LIB_LIBOPENJPEG;

(**
 * Sets the given function to be used as a read function.
 * @param       p_stream    the stream to modify
 * @param       p_function  the function to use a read function.
*)
procedure opj_stream_set_read_function(p_stream: Popj_stream_t; p_function: opj_stream_read_fn); cdecl; external LIB_LIBOPENJPEG;

(**
 * Sets the given function to be used as a write function.
 * @param       p_stream    the stream to modify
 * @param       p_function  the function to use a write function.
*)
procedure opj_stream_set_write_function(p_stream: Popj_stream_t; p_function: opj_stream_write_fn); cdecl; external LIB_LIBOPENJPEG;

(**
 * Sets the given function to be used as a skip function.
 * @param       p_stream    the stream to modify
 * @param       p_function  the function to use a skip function.
*)
procedure opj_stream_set_skip_function(p_stream: Popj_stream_t; p_function: opj_stream_skip_fn); cdecl; external LIB_LIBOPENJPEG;

(**
 * Sets the given function to be used as a seek function, the stream is then seekable.
 * @param       p_stream    the stream to modify
 * @param       p_function  the function to use a skip function.
*)
procedure opj_stream_set_seek_function(p_stream: Popj_stream_t; p_function: opj_stream_seek_fn); cdecl; external LIB_LIBOPENJPEG;

(**
 * Sets the given data to be used as a user data for the stream.
 * @param       p_stream    the stream to modify
 * @param       p_data      the data to set.
 * @param       p_function  the function to free p_data when opj_stream_destroy() is called.
*)
procedure opj_stream_set_user_data(p_stream: Popj_stream_t; p_data: pointer; p_function: opj_stream_free_user_data_fn); cdecl; external LIB_LIBOPENJPEG;

(**
 * Sets the length of the user data for the stream.
 *
 * @param p_stream    the stream to modify
 * @param data_length length of the user_data.
*)
procedure opj_stream_set_user_data_length(p_stream: Popj_stream_t; data_length: OPJ_UINT64); cdecl; external LIB_LIBOPENJPEG;

(**
 * Create a stream from a file identified with its filename with default parameters (helper function)
 * @param fname             the filename of the file to stream
 * @param p_is_read_stream  whether the stream is a read stream (true) or not (false)
*)
function opj_stream_create_default_file_stream(const fname: pchar; p_is_read_stream: OPJ_BOOL): Popj_stream_t; cdecl; external LIB_LIBOPENJPEG;

(** Create a stream from a file identified with its filename with a specific buffer size
 * @param fname             the filename of the file to stream
 * @param p_buffer_size     size of the chunk used to stream
 * @param p_is_read_stream  whether the stream is a read stream (true) or not (false)
*)
function opj_stream_create_file_stream(const fname: pchar; p_buffer_size: OPJ_SIZE_T; p_is_read_stream: OPJ_BOOL): Popj_stream_t; cdecl; external LIB_LIBOPENJPEG;

(*
==========================================================
   event manager functions definitions
==========================================================
*)
(**
 * Set the info handler use by openjpeg.
 * @param p_codec       the codec previously initialise
 * @param p_callback    the callback function which will be used
 * @param p_user_data   client object where will be returned the message
*)
function opj_set_info_handler(p_codec: Popj_codec_t; p_callback: opj_msg_callback; p_user_data: pointer): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;
(**
 * Set the warning handler use by openjpeg.
 * @param p_codec       the codec previously initialise
 * @param p_callback    the callback function which will be used
 * @param p_user_data   client object where will be returned the message
*)
function opj_set_warning_handler(p_codec: Popj_codec_t; p_callback: opj_msg_callback; p_user_data: pointer): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;
(**
 * Set the error handler use by openjpeg.
 * @param p_codec       the codec previously initialise
 * @param p_callback    the callback function which will be used
 * @param p_user_data   client object where will be returned the message
*)
function opj_set_error_handler(p_codec: Popj_codec_t; p_callback: opj_msg_callback; p_user_data: pointer): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(*
==========================================================
   codec functions definitions
==========================================================
*)

(**
 * Creates a J2K/JP2 decompression structure
 * @param format        Decoder to select
 *
 * @return Returns a handle to a decompressor if successful, returns NULL otherwise
 * *)
function opj_create_decompress(format: OPJ_CODEC_FORMAT): Popj_codec_t; cdecl; external LIB_LIBOPENJPEG;

(**
 * Destroy a decompressor handle
 *
 * @param   p_codec         decompressor handle to destroy
 *)
procedure opj_destroy_codec(p_codec: Popj_codec_t); cdecl; external LIB_LIBOPENJPEG;

(**
 * Read after the codestream if necessary
 * @param   p_codec         the JPEG2000 codec to read.
 * @param   p_stream        the JPEG2000 stream.
 *)
function opj_end_decompress(p_codec: Popj_codec_t; p_stream: Popj_stream_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;


(**
 * Set decoding parameters to default values
 * @param parameters Decompression parameters
 *)
procedure opj_set_default_decoder_parameters(parameters: Popj_dparameters_t); cdecl; external LIB_LIBOPENJPEG;

(**
 * Setup the decoder with decompression parameters provided by the user and with the message handler
 * provided by the user.
 *
 * @param p_codec       decompressor handler
 * @param parameters    decompression parameters
 *
 * @return true         if the decoder is correctly set
 *)
function opj_setup_decoder(p_codec: Popj_codec_t; parameters: Popj_dparameters_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Allocates worker threads for the compressor/decompressor.
 *
 * By default, only the main thread is used. If this function is not used,
 * but the OPJ_NUM_THREADS environment variable is set, its value will be
 * used to initialize the number of threads. The value can be either an integer
 * number, or "ALL_CPUS". If OPJ_NUM_THREADS is set and this function is called,
 * this function will override the behaviour of the environment variable.
 *
 * Note: currently only has effect on the decompressor.
 *
 * @param p_codec       decompressor handler
 * @param num_threads   number of threads.
 *
 * @return OPJ_TRUE     if the decoder is correctly set
 *)
function opj_codec_set_threads(p_codec: Popj_codec_t; num_threads: cint): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Decodes an image header.
 *
 * @param   p_stream        the jpeg2000 stream.
 * @param   p_codec         the jpeg2000 codec to read.
 * @param   p_image         the image structure initialized with the characteristics of encoded image.
 *
 * @return true             if the main header of the codestream and the JP2 header is correctly read.
 *)
function opj_read_header(p_stream: Popj_stream_t; p_codec: Popj_codec_t; p_image: PPopj_image_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;
        
(**
 * Sets the given area to be decoded. This function should be called right after opj_read_header and before any tile header reading.
 *
 * @param   p_codec         the jpeg2000 codec.
 * @param   p_image         the decoded image previously setted by opj_read_header
 * @param   p_start_x       the left position of the rectangle to decode (in image coordinates).
 * @param   p_end_x         the right position of the rectangle to decode (in image coordinates).
 * @param   p_start_y       the up position of the rectangle to decode (in image coordinates).
 * @param   p_end_y         the bottom position of the rectangle to decode (in image coordinates).
 *
 * @return  true            if the area could be set.
 *)
function opj_set_decode_area(p_codec: Popj_codec_t; p_image: Popj_image_t; p_start_x: OPJ_INT32; p_start_y: OPJ_INT32; p_end_x: OPJ_INT32; p_end_y: OPJ_INT32): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Decode an image from a JPEG-2000 codestream
 *
 * @param p_decompressor    decompressor handle
 * @param p_stream          Input buffer stream
 * @param p_image           the decoded image
 * @return                  true if success, otherwise false
 * *)
function opj_decode(p_decompressor: Popj_codec_t; p_stream: Popj_stream_t; p_image: Popj_image_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Get the decoded tile from the codec
 *
 * @param   p_codec         the jpeg2000 codec.
 * @param   p_stream        input streamm
 * @param   p_image         output image
 * @param   tile_index      index of the tile which will be decode
 *
 * @return                  true if success, otherwise false
 *)
function opj_get_decoded_tile(p_codec: Popj_codec_t; p_stream: Popj_stream_t; p_image: Popj_image_t; tile_index: OPJ_UINT32): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Set the resolution factor of the decoded image
 * @param   p_codec         the jpeg2000 codec.
 * @param   res_factor      resolution factor to set
 *
 * @return                  true if success, otherwise false
 *)
function opj_set_decoded_resolution_factor(p_codec: Popj_codec_t; res_factor: OPJ_UINT32): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Writes a tile with the given data.
 *
 * @param   p_codec             the jpeg2000 codec.
 * @param   p_tile_index        the index of the tile to write. At the moment, the tiles must be written from 0 to n-1 in sequence.
 * @param   p_data              pointer to the data to write. Data is arranged in sequence, data_comp0, then data_comp1, then ... NO INTERLEAVING should be set.
 * @param   p_data_size         this value os used to make sure the data being written is correct. The size must be equal to the sum for each component of
 *                              tile_width * tile_height * component_size. component_size can be 1,2 or 4 bytes, depending on the precision of the given component.
 * @param   p_stream            the stream to write data to.
 *
 * @return  true if the data could be written.
 *)
function opj_write_tile(p_codec: Popj_codec_t; p_tile_index: OPJ_UINT32; p_data: POPJ_BYTE; p_data_size: OPJ_UINT32; p_stream: Popj_stream_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Reads a tile header. This function is compulsory and allows one to know the size of the tile that will be decoded.
 * The user may need to refer to the image got by opj_read_header to understand the size being taken by the tile.
 *
 * @param   p_codec         the jpeg2000 codec.
 * @param   p_tile_index    pointer to a value that will hold the index of the tile being decoded, in case of success.
 * @param   p_data_size     pointer to a value that will hold the maximum size of the decoded data, in case of success. In case
 *                          of truncated codestreams, the actual number of bytes decoded may be lower. The computation of the size is the same
 *                          as depicted in opj_write_tile.
 * @param   p_tile_x0       pointer to a value that will hold the x0 pos of the tile (in the image).
 * @param   p_tile_y0       pointer to a value that will hold the y0 pos of the tile (in the image).
 * @param   p_tile_x1       pointer to a value that will hold the x1 pos of the tile (in the image).
 * @param   p_tile_y1       pointer to a value that will hold the y1 pos of the tile (in the image).
 * @param   p_nb_comps      pointer to a value that will hold the number of components in the tile.
 * @param   p_should_go_on  pointer to a boolean that will hold the fact that the decoding should go on. In case the
 *                          codestream is over at the time of the call, the value will be set to false. The user should then stop
 *                          the decoding.
 * @param   p_stream        the stream to decode.
 * @return  true            if the tile header could be decoded. In case the decoding should end, the returned value is still true.
 *                          returning false may be the result of a shortage of memory or an internal error.
 *)
function opj_read_tile_header(p_codec: Popj_codec_t; p_stream: Popj_stream_t; p_tile_index: POPJ_UINT32; p_data_size: POPJ_UINT32; p_tile_x0: POPJ_INT32; p_tile_y0: POPJ_INT32; p_tile_x1: POPJ_INT32; p_tile_y1: POPJ_INT32; p_nb_comps: POPJ_UINT32; p_should_go_on: POPJ_BOOL): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Reads a tile data. This function is compulsory and allows one to decode tile data. opj_read_tile_header should be called before.
 * The user may need to refer to the image got by opj_read_header to understand the size being taken by the tile.
 *
 * @param   p_codec         the jpeg2000 codec.
 * @param   p_tile_index    the index of the tile being decoded, this should be the value set by opj_read_tile_header.
 * @param   p_data          pointer to a memory block that will hold the decoded data.
 * @param   p_data_size     size of p_data. p_data_size should be bigger or equal to the value set by opj_read_tile_header.
 * @param   p_stream        the stream to decode.
 *
 * @return  true            if the data could be decoded.
 *)
function opj_decode_tile_data(p_codec: Popj_codec_t; p_tile_index: OPJ_UINT32; p_data: POPJ_BYTE; p_data_size: OPJ_UINT32; p_stream: Popj_stream_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(* COMPRESSION FUNCTIONS*)

(**
 * Creates a J2K/JP2 compression structure
 * @param   format      Coder to select
 * @return              Returns a handle to a compressor if successful, returns NULL otherwise
 *)
function opj_create_compress(format: OPJ_CODEC_FORMAT): Popj_codec_t; cdecl; external LIB_LIBOPENJPEG;

(**
Set encoding parameters to default values, that means :
<ul>
<li>Lossless
<li>1 tile
<li>Size of precinct : 2^15 x 2^15 (means 1 precinct)
<li>Size of code-block : 64 x 64
<li>Number of resolutions: 6
<li>No SOP marker in the codestream
<li>No EPH marker in the codestream
<li>No sub-sampling in x or y direction
<li>No mode switch activated
<li>Progression order: LRCP
<li>No index file
<li>No ROI upshifted
<li>No offset of the origin of the image
<li>No offset of the origin of the tiles
<li>Reversible DWT 5-3
</ul>
@param parameters Compression parameters
*)
procedure opj_set_default_encoder_parameters(parameters: Popj_cparameters_t); cdecl; external LIB_LIBOPENJPEG;

(**
 * Setup the encoder parameters using the current image and using user parameters.
 * @param p_codec       Compressor handle
 * @param parameters    Compression parameters
 * @param image         Input filled image
 *)
function opj_setup_encoder(p_codec: Popj_codec_t; parameters: Popj_cparameters_t; image: Popj_image_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Start to compress the current image.
 * @param p_codec       Compressor handle
 * @param p_image       Input filled image
 * @param p_stream      Input stgream
 *)
function opj_start_compress(p_codec: Popj_codec_t; p_image: Popj_image_t; p_stream: Popj_stream_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * End to compress the current image.
 * @param p_codec       Compressor handle
 * @param p_stream      Input stgream
 *)
function opj_end_compress(p_codec: Popj_codec_t; p_stream: Popj_stream_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(**
 * Encode an image into a JPEG-2000 codestream
 * @param p_codec       compressor handle
 * @param p_stream      Output buffer stream
 *
 * @return              Returns true if successful, returns false otherwise
 *)
function opj_encode(p_codec: Popj_codec_t; p_stream: Popj_stream_t): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;
(*
==========================================================
   codec output functions definitions
==========================================================
*)
(* EXPERIMENTAL FUNCTIONS FOR NOW, USED ONLY IN J2K_DUMP*)

(**
Destroy Codestream information after compression or decompression
@param cstr_info Codestream information structure
*)
procedure opj_destroy_cstr_info(cstr_info: PPopj_codestream_info_v2_t); cdecl; external LIB_LIBOPENJPEG;


(**
 * Dump the codec information into the output stream
 *
 * @param   p_codec         the jpeg2000 codec.
 * @param   info_flag       type of information dump.
 * @param   output_stream   output stream where dump the information gotten from the codec.
 *
 *)
procedure opj_dump_codec(p_codec: Popj_codec_t; info_flag: OPJ_INT32; var output_stream: file); cdecl; external LIB_LIBOPENJPEG;

(**
 * Get the codestream information from the codec
 *
 * @param   p_codec         the jpeg2000 codec.
 *
 * @return                  a pointer to a codestream information structure.
 *
 *)
function opj_get_cstr_info(p_codec: Popj_codec_t): Popj_codestream_info_v2_t; cdecl; external LIB_LIBOPENJPEG;

(**
 * Get the codestream index from the codec
 *
 * @param   p_codec         the jpeg2000 codec.
 *
 * @return                  a pointer to a codestream index structure.
 *
 *)
function opj_get_cstr_index(p_codec: Popj_codec_t): Popj_codestream_index_t; cdecl; external LIB_LIBOPENJPEG;

procedure opj_destroy_cstr_index(p_cstr_index: PPopj_codestream_index_t); cdecl; external LIB_LIBOPENJPEG;


(**
 * Get the JP2 file information from the codec FIXME
 *
 * @param   p_codec         the jpeg2000 codec.
 *
 * @return                  a pointer to a JP2 metadata structure.
 *
 *)
function opj_get_jp2_metadata(p_codec: Popj_codec_t): Popj_jp2_metadata_t; cdecl; external LIB_LIBOPENJPEG;

(**
 * Get the JP2 file index from the codec FIXME
 *
 * @param   p_codec         the jpeg2000 codec.
 *
 * @return                  a pointer to a JP2 index structure.
 *
 *)
function opj_get_jp2_index(p_codec: Popj_codec_t): Popj_jp2_index_t; cdecl; external LIB_LIBOPENJPEG;


(*
==========================================================
   MCT functions
==========================================================
*)

(**
 * Sets the MCT matrix to use.
 *
 * @param   parameters      the parameters to change.
 * @param   pEncodingMatrix the encoding matrix.
 * @param   p_dc_shift      the dc shift coefficients to use.
 * @param   pNbComp         the number of components of the image.
 *
 * @return  true if the parameters could be set.
 *)
function opj_set_MCT(parameters: Popj_cparameters_t; pEncodingMatrix: POPJ_FLOAT32; p_dc_shift: POPJ_INT32; pNbComp: OPJ_UINT32): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(*
==========================================================
   Thread functions
==========================================================
*)

(** Returns if the library is built with thread support.
 * OPJ_TRUE if mutex, condition, thread, thread pool are available.
 *)
function opj_has_thread_support(): OPJ_BOOL; cdecl; external LIB_LIBOPENJPEG;

(** Return the number of virtual CPUs *)
function opj_get_num_cpus(): cint; cdecl; external LIB_LIBOPENJPEG;


// #ifdef __cplusplus
// }
// #endif

// #endif (* OPENJPEG_H *)


implementation


end.

