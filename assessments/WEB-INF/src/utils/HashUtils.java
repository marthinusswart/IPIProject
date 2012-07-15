package utils;

import java.util.*;
import java.io.*;
import java.security.*;

public class HashUtils{
    
    
    
    /**
     * @param bytes
     * @return string of concatenated hex-values of byte array
     */
    private static String getString( byte[] bytes, boolean seperate ){
        StringBuffer sb = new StringBuffer();
        for( int i=0; i<bytes.length; i++ ){
            byte b = bytes[ i ];
            sb.append( ( Integer.toHexString((int) 0x00FF &  b) ) );
            if(seperate && i+1 < bytes.length ) sb.append( "-" );
        }
        return sb.toString();
    }
    
    private static byte[] getBytes( String str )    {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        StringTokenizer st = new StringTokenizer( str, "-", false );
        while( st.hasMoreTokens() )
        {
            int i = Integer.parseInt( st.nextToken() );
            bos.write( ( byte )i );
        }
        return bos.toByteArray();
    }
    
    public static String md5(String source){
        return md5(source, false);
    }
    public static String md5(String source , boolean seperate)    {
        try{
            MessageDigest md = MessageDigest.getInstance( "MD5" );
            byte[] bytes = md.digest( source.getBytes() );
            
            return getString( bytes , seperate );
        }
        catch( Exception e ){
            e.printStackTrace();
            return null;
        }
    }
    
    public static String sha(String source){
        return sha(source, false);
    }
    public static String sha(String source , boolean seperate)    {
        try        {
            MessageDigest md = MessageDigest.getInstance( "SHA" );
            byte[] bytes = md.digest( source.getBytes() );
            return getString( bytes , seperate );
        }
        catch( Exception e )        {
            e.printStackTrace();
            return null;
        }
    }
    
    /*  public static void main( String[] args )
     {
     if( args.length < 1 )
     {
     System.out.println( "Usage: HashUtils word" );
     System.exit( 0 );
     }
     String word = args[ 0 ];
     System.out.println( "Word: " + word );
     
     String md5 = HashUtils.md5( word );
     System.out.println( " MD5: " + md5);
     System.out.println( " SHA: " + HashUtils.sha( word ) );
     }*/
}
