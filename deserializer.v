`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/27 14:07:12
// Design Name: 
// Module Name: deserializer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module deserializer(
        input               clk_3M,                 //3Mhzʱ��
        input               rst,                    //��λ�ź�
        input               deserializer_wait,      //����ת����ͣ�ź�
        input               data_in,                //��������
        output reg[15:0]    data_out,              //�������
        output reg          data_get_o             //16λ������Ч�ź�
    );
    
    reg[4:0]    index;
    reg         data_get;
    reg         data_get_org;
    reg         pre_rst;
    
    always @(posedge clk_3M ) begin
        data_get_org<=data_get;
        pre_rst<=rst;
        if(rst==1'b0)begin
            data_out<=16'h0;
            index<=5'h0;
        end else if(deserializer_wait==1'b0) begin
            index<=index+1;
            if(index==5'hf)begin
                index<=5'h0;
            end
            data_out[15-index]<=data_in;
        end else begin
            data_out<=data_out;
            index<=5'h0;
        end
    end
    
    
    always @(*)begin
        if(data_get_org==1'b0&&data_get==1'b1)begin
            data_get_o<=1'b1&&pre_rst;
        end else begin
            data_get_o<=1'b0;
        end
    end
    
    always @(*) begin
        if(rst==1'b0)begin
            data_get<=1'b0;
        end else begin
            if(index==5'h0)begin
                data_get<=1'b1;
            end else begin
                data_get<=1'b0;
            end
        end
    end
    
    
endmodule