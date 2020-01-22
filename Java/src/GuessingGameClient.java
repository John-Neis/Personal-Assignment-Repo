import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.IOException;

import java.net.Socket;
import java.net.ServerSocket;
import java.net.UnknownHostException;

public class GuessingGameClient 
{
    public static void main(String args[]) 
    {
        if(args.length != 2) 
        {
            System.err.println(
                "Usage: java EchoClient <host name> <port number>");
            System.exit(1);
        }

        String hostName = args[0];
        int portNumber = Integer.parseInt(args[1]);

        try 
        {
            Socket server = new Socket(hostName, portNumber);
            System.out.println("Connection established.");
            PrintWriter output = new PrintWriter(server.getOutputStream(), true);
            BufferedReader input = new BufferedReader(
                    new InputStreamReader(server.getInputStream()));
            BufferedReader stdIn = new BufferedReader(
                    new InputStreamReader(System.in));

            String userInput = stdIn.readLine();
            while (!userInput.equalsIgnoreCase("quit")) {
                output.println(userInput);
                String serverin = input.readLine();
                System.out.println(serverin);
                if(serverin.contains("tly"))
                {
                    System.exit(1);
                }
                userInput = stdIn.readLine();
            }
            server.close();
        }
        catch(UnknownHostException e)
        {
            System.err.println("Don't know about host " + hostName);
            System.exit(1);
        }
        catch(IOException e)
        {
            System.err.println("Couldn't get I/O for the connection to " +
                hostName);
            System.exit(1);
        }
    }
}