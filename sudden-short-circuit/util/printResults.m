function printResults(out,title)
    fprintf(title + ":\n");
    fprintf("Xd' = %.3f and Xd'' = %.3f;\n",out.xTran,out.xSubTran); 
    fprintf("Td0' = %.2fs and Td0'' = %.3fs.\n",out.tTran,out.tSubTran);
end