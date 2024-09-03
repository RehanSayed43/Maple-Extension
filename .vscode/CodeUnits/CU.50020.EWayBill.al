// codeunit 50020 "E-WayBill"
// {

//     Permissions = TableData 112 = rimd;

//     trigger OnRun()
//     begin
//     end;

//     var
//         Httpclint: HttpClient;
//         HttpContnt: HttpContent;
//         HttpResponseMsg: HttpResponseMessage;
//         HttpHdr: HttpHeaders;
//         SearchType: Text;
//         jtoken: JsonToken;
//         Test: Text;
//         // EwayBillDLL: DotNet Nav;//tk
//         reson: Option "1","2","3","4";
//         RecLocation: Record 14;
//         Recstate: Record State;
//         Result: Text;
//         // Parameters: DotNet EWayBillParameters;
//         txtDistance: Text;
//         RecCompanyInfo: Record 79;
//         RecGeneLedSetup: Record 98;
//         GenText: Label 'Do You Want to Generate E-Way Bill No.';
//         UpdateVehtxt: Label 'Do You Want to Update Vehicle No.';
//         Canceltxt: Label 'Do You Want to Cancel E-Way Bill No.';
//         Rejecttxt: Label 'Do You Want to Reject E-Way Bill No.';
//         Extendtxt: Label 'Do You Want to Extend E-Way Bill No.';
//         Updatetranstxt: Label 'Do You Want to Update Transporter';
//         errormsg: Text;
//         VARVehicleType: Option ,R,O;
//         ewayno: Text;
//         ErrorText: Text;
//         Text001: Label 'E-Way Bill Not Generated For Invocie No. %1. Please Check Error Log.';
//         SuccessText: Text;
//         Text002: Label 'E-Way Bill Generated Successfully.';
//         RecEWayBillEntry: Record 50002;
//         Text005: Label 'Vehicle No. Not Updated For Invoice No. %1. Please Check Error Log';
//         EWayOperation: Option " ","Generate EWB","Update Vehicle No.","Generate CEWB","Cancel EWB","Reject EWB","Update Transporter","Extend Validity of EWB","Re-Gen CEWB","Get EWB Details","Get EWB Assign for Trans.","Get EWB Assign to Trans by GSTIN","Get EWB gen on req of Other Party","Get CEWB","Get GSTIN details","Get Transin details","Get HSN details","Print EWB";
//         Text008: Label 'E-Way Bill Validity Not Extended For Invoice No. %1. Please Check Error Log';
//         VehSucess: Label 'Vehicle No. Updated Sucessfully.';
//         EwayCanSucess: Label 'E-Way Bill No Canceled Sucessfully';
//         Text009: Label 'E-Way Bill No Not Cancelled Please Check Error Log';
//         ExSucess: Label 'E-Way Bill Validity Extended Sucessfully';
//         RecEWayBillEntry1: Record 50002;
//         RecLoc: Record 14;
//         RecTSL: Record 5745;
//         RecLocDest: Record 14;
//         RecPCML: Record 125;
//         LocalPathAndFileName: Text;
//         FileManagement: Codeunit 419;
//         OPFile: Text;


//     // procedure "E-WayBillGeneration"(RecSIH: Record 112)
//     // var
//     //     RecSInvL: Record 113;
//     //     BodyJson: JsonObject;
//     // begin
//     //     //Generate eWay Bill No. for Sales++
//     //     ErrorText := '';
//     //     RecGeneLedSetup.GET;
//     //     RecSIH.CALCFIELDS("Amount");
//     //     VARVehicleType := RecSIH."Vehicle Type";
//     //     IF (RecSIH."Amount" >= RecGeneLedSetup."E-Way Amount Limit") AND (RecSIH.Distance >= RecGeneLedSetup."E-Way Distance Limit") THEN BEGIN
//     //         RecSIH.TESTFIELD("Posting Date");
//     //         // RecSIH.TESTFIELD("Location GST Reg. No.");
//     //         // RecSIH.TESTFIELD("Customer GST Reg. No.");
//     //         RecSIH.TESTFIELD("Location Code");
//     //         RecSIH.TESTFIELD("Sell-to Post Code");
//     //         RecSIH.TESTFIELD("GST Bill-to State Code");
//     //         // RecSIH.TESTFIELD(Distance);
//     //         //  RecSIH.TESTFIELD("Vehicle Type");
//     //         //   RecSIH.TESTFIELD("Transport Method");
//     //         // RecSIH.TESTFIELD("Vehicle No.");
//     //         // RecSIH.TESTFIELD("LR/RR No.");
//     //         //RecSIH.TESTFIELD("LR/RR Date");//tk
//     //         RecSInvL.RESET;
//     //         RecSInvL.SETRANGE("Document No.", RecSIH."No.");
//     //         RecSInvL.SETRANGE(Type, RecSInvL.Type::Item);
//     //         IF RecSInvL.FINDSET THEN
//     //             REPEAT
//     //                 RecSInvL.TESTFIELD(RecSInvL."HSN/SAC Code")
//     //             UNTIL RecSInvL.NEXT = 0;
//     //         RecLocation.GET(RecSIH."Location Code");
//     //         RecLocation.TESTFIELD("Post Code");
//     //         RecLocation.TESTFIELD("GST Registration No.");
//     //         RecLocation.TESTFIELD("State Code");
//     //         RecLocation.TESTFIELD("E-Invoice User ID");
//     //         RecLocation.TESTFIELD("E-Invoice Password");
//     //         BodyJson.add('Irn', RecSIH."IRN No.");
//     //         BodyJson.Add('TransId', RecSIH.);
//     //         BodyJson.Add('TransMode', RecSIH."Mode of Transport");
//     //         BodyJson.Add('TrnDocNO', RecSIH.transport);
//     //         BodyJson.Add('TrnDocDt', RecSIH."Transport Method");



//     //         "Irn":"825a63fc30ab5e948c47d460f0bc3ca615b8389d98bf38f56ff49df6160de06e",
//     //         "TransId":"29DPZPS4403C1ZF",
//     //         "TransMode":"1",
//     //         "TrnDocNO ":"12/22",
//     //         " TrnDocDt ":"06/02/2020",
//     //         " VehNo ":" KA01AB1234 ",
//     //         " Distance ":120,
//     //         " VehType ":" R ",
//     //         " TransName ":" ree "}


//     //         IF CONFIRM(GenText, TRUE) THEN BEGIN
//     //             PostUrl := 'PAste URL here';
//     //             HttpHdr.Add('app-name', 'Navision');
//     //             HttpHdr.Add('x-token', '241a4d366da38e2d53361dbe65a36d023065f399');
//     //             HttpHdr.Remove('Content-Type');
//     //             HttpHdr.Add('Content-Type', 'application/json');

//     //             HttpContnt.WriteFrom(format(ReqGenerateIRN));
//     //             HttpContnt.GetHeaders(HttpHdr);
//     //             if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin

//     //                 HttpResponseMsg.Content.ReadAs(Result);
//     //                 ResultObject.ReadFrom(Result);
//     //             end;
//     //             //  MESSAGE('%1,%2',RecLocation."E-Invoice User ID",RecLocation."E-Invoice Password");
//     //             // EwayBillDLL := EwayBillDLL.Nav;
//     //             // Test := EwayBillDLL.GenEwBillForSales(RecSIH."No.", COMPANYNAME, 'O', '1', 'INV', 1, '', RecLocation."E-Invoice User ID", RecLocation."E-Invoice Password", USERID, FORMAT(VARVehicleType));

//     //             // MESSAGE(Test);//tk
//     //             /*
//     //              IF COPYSTR(Test,1,10)='E-Way Bill' THEN
//     //                 MESSAGE(Text002)
//     //              ELSE  IF COPYSTR(Test,1,19)='ErrorFromNICServer-' THEN
//     //                 ErrorText+=RecSIH."No."
//     //              ELSE BEGIN
//     //              //EwayServerErrorEntry(FALSE,RecSIH."No.",Test,'','',EWayOperation::"Generate EWB",USERID);
//     //                 ErrorText+=RecSIH."No.";
//     //              END;
//     //                IF ErrorText<>'' THEN
//     //                MESSAGE(Text001,DELSTR(ErrorText,STRLEN(ErrorText)-1,STRLEN(ErrorText)));
//     //                */
//     //         END;
//     //     END ELSE
//     //         ERROR('Check E-Way Amount and E-Way Distance Limit in General Ledger Setup');
//     //     //Generate eWay Bill No. for Sales--

//     // end;

//     ////tk
//     procedure "E-WayBillGenerationTransferShipment"(RecTSH: Record 5744)
//     begin
//         //Generate eWay Bill No. for Transfer++
//         //CLEAR(EwayBillDLL);
//         CLEAR(VARVehicleType);

//         //CLEAR(subsupplytype);
//         //CLEAR(EWayDocType);
//         //CLEAR(EWayTransType);
//         RecGeneLedSetup.GET;
//         //RecTSH.CALCFIELDS("Total  Line Amount");


//         VARVehicleType := RecTSH."Vehicle Type";
//         //subsupplytype:=RecTSH."Sub Supply Type";
//         //EWayDocType:=RecTSH."E-Way Bill Document Type";
//         //EWayTransType:=RecTSH."E-Way Transaction Type";

//         //IF (RecTSH."Total  Line Amount" >=RecGeneLedSetup."E-Way Amount Limit") AND
//         IF (RecTSH.Distance >= RecGeneLedSetup."E-Way Distance Limit") THEN BEGIN
//             RecTSH.TESTFIELD("Posting Date");
//             RecTSH.TESTFIELD("Transfer-from Code");
//             RecTSH.TESTFIELD("Transfer-to Code");
//             RecTSH.TESTFIELD("Transfer-from Post Code");
//             RecTSH.TESTFIELD("Transfer-to Post Code");
//             // RecTSH.TESTFIELD("Vehicle No.");
//             // RecTSH.TESTFIELD("Vehicle Type");
//             //  RecTSH.TESTFIELD("Dispatch From");
//             //  RecTSH.TESTFIELD("E-Way Transaction Type");
//             // RecTSH.TESTFIELD("Dispatch To");
//             //RecTSH.TESTFIELD("LR/RR No.");

//             //RecTSH.TESTFIELD("LR/RR Date");
//             RecLoc.GET(RecTSH."Transfer-from Code");
//             RecLoc.TESTFIELD("Post Code");
//             //RecLoc.TESTFIELD("E-Way Loc Name");
//             RecLoc.TESTFIELD("GST Registration No.");
//             RecLoc.TESTFIELD("State Code");
//             RecLoc.TESTFIELD("E-Invoice User ID");
//             RecLoc.TESTFIELD("E-Invoice Password");
//             RecLocDest.GET(RecTSH."Transfer-to Code");
//             RecLocDest.TESTFIELD("Post Code");
//             RecLocDest.TESTFIELD("GST Registration No.");
//             RecLocDest.TESTFIELD("State Code");
//             RecTSL.RESET;
//             RecTSL.SETRANGE("Document No.", RecTSH."No.");
//             RecTSL.SETFILTER("Item No.", '<>%1', '');
//             IF RecTSL.FINDSET THEN
//                 REPEAT
//                     RecTSL.TESTFIELD(RecTSL."HSN/SAC Code")
//                 UNTIL RecTSL.NEXT = 0;

//             IF CONFIRM(GenText, TRUE) THEN BEGIN

//                 //EwayBillDLL := EwayBillDLL.Nav;//
//                                                // 'O','3','CHL',1,''
//                                                //7 Others
//                                                //4 For Own use
//                                                //    MESSAGE(FORMAT(COMPANYNAME));
//                // Test := EwayBillDLL.GenEwBillForTransfers(RecTSH."No.", COMPANYNAME, 'O', '4', 'CHL', 1, '', RecLoc."E-Invoice User ID", RecLoc."E-Invoice Password", USERID, FORMAT(VARVehicleType));
//                 MESSAGE(Test);
//             END;
//         END ELSE
//             ERROR('Check E-Way Amount and E-Way Distance Limit in General Ledger Setup');
//         //Generate eWay Bill No. for Transfer++
//     end;


//     // procedure "E-WayBillGenerationPurchaseCreditMemo"(RecPCMH: Record "124")
//     // var
//     //     RecLoc: Record "14";
//     //     RecPCML: Record "125";
//     //     RecVendor: Record "23";
//     // begin
//     //     //Generate eWay Bill No. for Purchase Return++
//     //     ErrorText := '';
//     //     RecGeneLedSetup.GET;
//     //     RecPCMH.CALCFIELDS("Amount to Vendor");
//     //     VARVehicleType := RecPCMH."Vehicle Type";
//     //     RecPCMH.TESTFIELD("Amount to Vendor");
//     //     IF (RecPCMH."Amount to Vendor" >= RecGeneLedSetup."E-Way Amount Limit") AND (RecPCMH.Distance >= RecGeneLedSetup."E-Way Distance Limit") THEN BEGIN
//     //         RecPCMH.TESTFIELD("Posting Date");
//     //         // RecPCMH.TESTFIELD("Location GST Reg. No.");
//     //         // RecPCMH.TESTFIELD("Vendor GST Reg. No.");
//     //         RecPCMH.TESTFIELD("Location Code");
//     //         RecPCMH.TESTFIELD("Buy-from Post Code");
//     //         RecVendor.GET(RecPCMH."Buy-from Vendor No.");
//     //         // RecPCMH.TESTFIELD("Vehicle No.");
//     //         ///  RecPCMH.TESTFIELD("Vehicle Type");
//     //         // RecPCMH.TESTFIELD("LR/RR No.");
//     //         // RecPCMH.TESTFIELD("LR/RR Date");
//     //         RecVendor.TESTFIELD("State Code");
//     //         //RecPCMH.TESTFIELD(Distance);
//     //         //RecPCMH.TESTFIELD("Vehicle No.");
//     //         RecPCML.RESET;
//     //         RecPCML.SETRANGE("Document No.", RecPCMH."No.");
//     //         RecPCML.SETFILTER("No.", '<>%1', '');
//     //         RecPCML.SETRANGE(Type, RecPCML.Type::Item);
//     //         IF RecPCML.FINDSET THEN
//     //             REPEAT
//     //                 RecPCML.TESTFIELD(RecPCML."HSN/SAC Code")
//     //             UNTIL RecPCML.NEXT = 0;
//     //         RecLoc.GET(RecPCMH."Location Code");
//     //         RecLoc.TESTFIELD("Post Code");
//     //         RecLoc.TESTFIELD("GST Registration No.");
//     //         RecLoc.TESTFIELD("State Code");
//     //         RecLoc.TESTFIELD("E-Invoice User ID");
//     //         RecLoc.TESTFIELD("E-Invoice Password");
//     //         IF CONFIRM(GenText, TRUE) THEN BEGIN
//     //             EwayBillDLL := EwayBillDLL.Nav;

//     //             //  Test:=EwayBillDLL.GenEwBillForPurchaseReturn(RecPCMH."No.",COMPANYNAME,'O','4','CNT','',RecLoc."E-Invoice User ID",RecLoc."E-Invoice Password",USERID,FORMAT(VARVehicleType));

//     //             IF COPYSTR(Test, 1, 10) = 'E-Way Bill' THEN
//     //                 MESSAGE(Text002)
//     //             ELSE
//     //                 IF COPYSTR(Test, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                     ErrorText += RecPCMH."No."
//     //                 ELSE BEGIN
//     //                     // EwayServerErrorEntry(FALSE,RecPCMH."No.",Test,'','',EWayOperation::"Generate EWB",USERID);
//     //                     ErrorText += RecPCMH."No.";
//     //                 END;
//     //             IF ErrorText <> '' THEN
//     //                 MESSAGE(Text001, DELSTR(ErrorText, STRLEN(ErrorText) - 1, STRLEN(ErrorText)));
//     //         END;
//     //     END ELSE
//     //         ERROR('Check E-Way Amount and E-Way Distance Limit in General Ledger Setup');
//     //     //Generate eWay Bill No. for Purchase Return--
//     // end;

//     //
//     // procedure "E-WayUpdteVehicleNoSales"(RecSalesInv: Record "112")
//     // var
//     //     CommaCount: Integer;
//     //     TotalStrCount: Integer;
//     //     I: Integer;
//     //     SeparateString: Text;
//     // begin
//     //     //Update Vehicle No. For Sales++
//     //     WITH RecSalesInv DO BEGIN
//     //         RecSalesInv.TESTFIELD("E-Way Bill No.");
//     //         RecSalesInv.TESTFIELD("Vehicle No.");
//     //         RecSalesInv.TESTFIELD("LR/RR No.");
//     //         // RecSalesInv.TESTFIELD("Update Vehicle Reason Remark");
//     //         // RecSalesInv.TESTFIELD("Vehicle Update Reason");
//     //         RecSalesInv.TESTFIELD("LR/RR Date");
//     //         RecSalesInv.TESTFIELD("Vehicle Type");
//     //         VARVehicleType := "Vehicle Type";
//     //         // reson:= "Vehicle Update Reason";
//     //         IF RecLocation.GET("Location Code") THEN BEGIN
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");
//     //             IF Recstate.GET(State) THEN;
//     //             Parameters := Parameters.EWayBillParameters;
//     //             Parameters.CompanyName := COMPANYNAME;
//     //             Parameters.FromGstin := RecLocation."GST Registration No.";
//     //             Parameters.EWayBillNo := "E-Way Bill No.";
//     //             Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //             Parameters.VehicleNo := "Vehicle No.";
//     //             Parameters.FromPlace := RecLocation.City;
//     //             Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //             Parameters.ReasonCode := FORMAT(reson);
//     //             // Parameters.Remarks:="Update Vehicle Reason Remark";
//     //             Parameters.TransDocNo := "LR/RR No.";
//     //             Parameters.TransDocDate := FORMAT("LR/RR Date", 10, '<Day,2>/<Month,2>/<Year4>');
//     //             Parameters.TransMode := "Transport Method";
//     //             Parameters.VehicleType := FORMAT(VARVehicleType);
//     //             Parameters.InvoiceNo := "No.";
//     //             Parameters.TransactionType := '1';
//     //             Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //             Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //             Parameters.UserId := USERID;
//     //             IF CONFIRM(UpdateVehtxt, TRUE) THEN BEGIN
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.UpdateVehicleNo(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN
//     //                     MESSAGE(VehSucess)
//     //                 ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += RecSalesInv."No."
//     //                     ELSE BEGIN
//     //                         //  EwayServerErrorEntry(FALSE,RecSalesInv."No.",Result,'','',EWayOperation::"Update Vehicle No.",USERID);
//     //                         ErrorText += RecSalesInv."No.";
//     //                     END;
//     //                 IF ErrorText <> '' THEN
//     //                     MESSAGE(Text005, DELSTR(ErrorText, STRLEN(ErrorText) - 1, STRLEN(ErrorText)));
//     //                 //***
//     //             END;
//     //         END;
//     //     END;
//     //     //Update Vehicle No. For Sales--
//     // end;

//     //
//     // procedure "E-WayUpdteVehicleNoTransfer"(RecTransShipHeader: Record "5744")
//     // var
//     //     CommaCount: Integer;
//     //     TotalStrCount: Integer;
//     //     I: Integer;
//     //     SeparateString: Text;
//     // begin
//     //     //Update Vehicle No. for Transfer++
//     //     WITH RecTransShipHeader DO BEGIN
//     //         RecTransShipHeader.TESTFIELD("E-Way Bill No.");
//     //         RecTransShipHeader.TESTFIELD("Vehicle No.");
//     //         RecTransShipHeader.TESTFIELD("LR/RR No.");
//     //         RecTransShipHeader.TESTFIELD("LR/RR Date");
//     //         // TESTFIELD("Update Vehicle Reason Remark");
//     //         TESTFIELD("Vehicle Type");
//     //         VARVehicleType := "Vehicle Type";
//     //         // reson:= "Vehicle Update Reason";
//     //         IF RecLocation.GET("Transfer-from Code") THEN BEGIN
//     //             IF Recstate.GET(RecLocation."State Code") THEN;
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");
//     //             Parameters := Parameters.EWayBillParameters;
//     //             Parameters.CompanyName := COMPANYNAME;
//     //             Parameters.FromGstin := RecLocation."GST Registration No.";
//     //             Parameters.EWayBillNo := "E-Way Bill No.";
//     //             Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //             Parameters.VehicleNo := "Vehicle No.";
//     //             Parameters.FromPlace := RecLocation.City;
//     //             Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //             Parameters.ReasonCode := FORMAT(reson);
//     //             Parameters.Remarks := '';//"Update Vehicle Reason Remark";
//     //             Parameters.TransDocNo := "LR/RR No.";
//     //             Parameters.TransDocDate := FORMAT("LR/RR Date", 10, '<Day,2>/<Month,2>/<Year4>');
//     //             Parameters.TransMode := "Transport Method";
//     //             Parameters.VehicleType := FORMAT(VARVehicleType);
//     //             Parameters.InvoiceNo := "No.";
//     //             Parameters.TransactionType := '3';
//     //             Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //             Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //             Parameters.UserId := USERID;
//     //             IF CONFIRM(UpdateVehtxt, TRUE) THEN BEGIN
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.UpdateVehicleNo(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN
//     //                     MESSAGE(VehSucess)
//     //                 ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += "No."
//     //                     ELSE BEGIN
//     //                         //  EwayServerErrorEntry(FALSE,"No.",Result,'','',EWayOperation::"Update Vehicle No.",USERID);
//     //                         ErrorText += "No.";
//     //                     END;
//     //                 IF ErrorText <> '' THEN
//     //                     MESSAGE(Text005, DELSTR(ErrorText, STRLEN(ErrorText) - 1, STRLEN(ErrorText)));
//     //                 //***
//     //             END;
//     //         END;
//     //     END;
//     //     //Update Vehicle No. for Transfer--
//     // end;

//     //
//     // procedure "E-WayUpdteVehicleNoPurchaseReturn"(RecPurchCrMemoHeader: Record "124")
//     // var
//     //     CommaCount: Integer;
//     //     TotalStrCount: Integer;
//     //     I: Integer;
//     //     SeparateString: Text;
//     // begin
//     //     //Update Vehicle No. For Purchase Return++
//     //     WITH RecPurchCrMemoHeader DO BEGIN
//     //         TESTFIELD("E-Way Bill No.");
//     //         TESTFIELD("Vehicle No.");
//     //         // TESTFIELD("LR/RR No.");
//     //         //  TESTFIELD("Update Vehicle Reason Remark");
//     //         //  TESTFIELD("Vehicle Update Reason");
//     //         // TESTFIELD("LR/RR Date");
//     //         TESTFIELD("Vehicle Type");
//     //         VARVehicleType := "Vehicle Type";
//     //         // reson:= "Vehicle Update Reason";
//     //         IF RecLocation.GET("Location Code") THEN BEGIN
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");
//     //             IF Recstate.GET(State) THEN;
//     //             Parameters := Parameters.EWayBillParameters;
//     //             Parameters.CompanyName := COMPANYNAME;
//     //             Parameters.FromGstin := RecLocation."GST Registration No.";
//     //             Parameters.EWayBillNo := "E-Way Bill No.";
//     //             Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //             Parameters.VehicleNo := "Vehicle No.";
//     //             Parameters.FromPlace := RecLocation.City;
//     //             Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //             Parameters.ReasonCode := FORMAT(reson);
//     //             Parameters.Remarks := '';//"Update Vehicle Reason Remark";
//     //             Parameters.TransDocNo := '';//"LR/RR No.";
//     //             Parameters.TransDocDate := '';//FORMAT("LR/RR Date",10,'<Day,2>/<Month,2>/<Year4>');
//     //             Parameters.TransMode := "Transport Method";
//     //             Parameters.VehicleType := FORMAT(VARVehicleType);
//     //             Parameters.InvoiceNo := "No.";
//     //             Parameters.TransactionType := '4';
//     //             Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //             Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //             Parameters.UserId := USERID;
//     //             IF CONFIRM(UpdateVehtxt, TRUE) THEN BEGIN
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.UpdateVehicleNo(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN
//     //                     MESSAGE(VehSucess)
//     //                 ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += "No."
//     //                     ELSE BEGIN
//     //                         //  EwayServerErrorEntry(FALSE,"No.",Result,'','',EWayOperation::"Update Vehicle No.",USERID);
//     //                         ErrorText += "No.";
//     //                     END;
//     //                 IF ErrorText <> '' THEN
//     //                     MESSAGE(Text005, DELSTR(ErrorText, STRLEN(ErrorText) - 1, STRLEN(ErrorText)));
//     //                 //***
//     //             END;
//     //         END;
//     //     END;
//     //     //Update Vehicle No. For Purchase Return--
//     // end;

//     //
//     // procedure "CancelE-WayBillSales"(RecSalesInv: Record "112")
//     // begin
//     //     ////Cancel E-Way for Sales++
//     //     WITH RecSalesInv DO BEGIN
//     //         reson := "Cancel Reason Code";
//     //         RecSalesInv.TESTFIELD("E-Way Bill No.");
//     //         // RecSalesInv.TESTFIELD("Vehicle No.");
//     //         // RecSalesInv.TESTFIELD("LR/RR No.");
//     //         // RecSalesInv.TESTFIELD("LR/RR Date");
//     //         RecSalesInv.TESTFIELD("Cancel Reason Code");
//     //         RecSalesInv.TESTFIELD("Cancel Remark");
//     //         // reson:= "Vehicle Update Reason";
//     //         IF RecLocation.GET("Location Code") THEN BEGIN
//     //             IF Recstate.GET(State) THEN;
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");
//     //             Parameters := Parameters.EWayBillParameters;
//     //             Parameters.CompanyName := COMPANYNAME;
//     //             Parameters.FromGstin := RecLocation."GST Registration No.";
//     //             Parameters.TransactionType := '1';
//     //             Parameters.CancelRemarks := "Cancel Remark";
//     //             Parameters.CancelReasonCode := FORMAT(reson);
//     //             Parameters.EWayBillNo := "E-Way Bill No.";
//     //             Parameters.InvoiceNo := "No.";
//     //             Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //             Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //             Parameters.UserId := USERID;
//     //             IF CONFIRM(Canceltxt, TRUE) THEN BEGIN
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.CancelEwBill(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     MESSAGE(EwayCanSucess);
//     //                     "E-Way Bill No." := '';
//     //                     "E-Way Bill Date" := 0DT;
//     //                     // "Sub Supply Type":="Sub Supply Type"::Supply;
//     //                     //  "Sub-Type":= "Sub-Type"::Supply;
//     //                     //"Update Vehicle Reason Remark":='';
//     //                     "Vehicle Type" := "Vehicle Type"::" ";
//     //                     //"Vehicle Update Reason":="Vehicle Update Reason"::"0";
//     //                     //"E-Way Bill Valid Upto":=0DT;
//     //                     RecSalesInv.MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += RecSalesInv."No."
//     //                     ELSE BEGIN
//     //                         //   EwayServerErrorEntry(FALSE,RecSalesInv."No.",Result,'','',EWayOperation::"Cancel EWB",USERID);
//     //                         ErrorText += RecSalesInv."No.";
//     //                     END;
//     //                 //***
//     //             END;
//     //         END;
//     //     END;
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE('E-Way Bill No Not Cancelled ' + ErrorText + ' Please Check Error Log');
//     //     //Cancel E-Way for Sales--
//     // end;

//     //
//     // procedure "CancelE-WayBillTransfer"(RecTransShipHeader: Record "5744")
//     // begin
//     //     //Cancel eWay for Transfer++
//     //     WITH RecTransShipHeader DO BEGIN
//     //         RecTransShipHeader.TESTFIELD("E-Way Bill No.");
//     //         // RecTransShipHeader.TESTFIELD("Vehicle No.");
//     //         // RecTransShipHeader.TESTFIELD("LR/RR No.");
//     //         // RecTransShipHeader.TESTFIELD("LR/RR Date");
//     //         RecTransShipHeader.TESTFIELD("Cancel Reason Code");
//     //         RecTransShipHeader.TESTFIELD("Cancel Remark");
//     //         reson := "Cancel Reason Code";
//     //         IF RecLocation.GET("Transfer-from Code") THEN BEGIN
//     //             IF Recstate.GET(RecLocation."State Code") THEN;
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");
//     //             Parameters := Parameters.EWayBillParameters;
//     //             Parameters.CompanyName := COMPANYNAME;
//     //             Parameters.FromGstin := RecLocation."GST Registration No.";
//     //             Parameters.TransactionType := '3';
//     //             Parameters.CancelRemarks := "Cancel Remark";
//     //             Parameters.CancelReasonCode := FORMAT(reson);
//     //             Parameters.EWayBillNo := "E-Way Bill No.";
//     //             Parameters.InvoiceNo := "No.";
//     //             Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //             Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //             Parameters.UserId := USERID;
//     //             IF CONFIRM(Canceltxt, TRUE) THEN BEGIN
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.CancelEwBill(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     MESSAGE(EwayCanSucess);
//     //                     "E-Way Bill No." := '';
//     //                     "E-Way Bill Date" := 0DT;
//     //                     //"Sub Supply Type":="Sub Supply Type"::Supply;
//     //                     //"Update Vehicle Reason Remark":='';
//     //                     "Vehicle Type" := "Vehicle Type"::" ";
//     //                     //"Vehicle Update Reason":="Vehicle Update Reason"::"1";
//     //                     //"E-Way Bill Valid Upto":=0DT;
//     //                     RecTransShipHeader.MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += RecTransShipHeader."No."
//     //                     ELSE BEGIN
//     //                         //   EwayServerErrorEntry(FALSE,RecTransShipHeader."No.",Result,'','',EWayOperation::"Cancel EWB",USERID);
//     //                         ErrorText += RecTransShipHeader."No.";
//     //                     END;
//     //                 //***
//     //             END;
//     //         END;
//     //     END;
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE('E-Way Bill No Not Cancelled ' + ErrorText + ' Please Check Error Log');
//     //     //Cancel eWay for Transfer--
//     // end;

//     //
//     // procedure "CancelE-WayBillPurchaseReturn"(var RecPurchCrMemoHeader: Record "124")
//     // begin
//     //     //Cancel E-Way for Purchase Return++
//     //     WITH RecPurchCrMemoHeader DO BEGIN
//     //         reson := "Cancel Reason Code";
//     //         TESTFIELD("E-Way Bill No.");
//     //         TESTFIELD("Vehicle No.");
//     //         // TESTFIELD("LR/RR No.");
//     //         // TESTFIELD("LR/RR Date");
//     //         TESTFIELD("Cancel Reason Code");
//     //         TESTFIELD("Cancel Remark");
//     //         // reson:= "Vehicle Update Reason";
//     //         IF RecLocation.GET("Location Code") THEN BEGIN
//     //             IF Recstate.GET(State) THEN;
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");
//     //             Parameters := Parameters.EWayBillParameters;
//     //             Parameters.CompanyName := COMPANYNAME;
//     //             Parameters.FromGstin := RecLocation."GST Registration No.";
//     //             Parameters.TransactionType := '4';
//     //             Parameters.CancelRemarks := "Cancel Remark";
//     //             Parameters.CancelReasonCode := FORMAT(reson);
//     //             Parameters.EWayBillNo := "E-Way Bill No.";
//     //             Parameters.InvoiceNo := "No.";
//     //             Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //             Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //             Parameters.UserId := USERID;
//     //             IF CONFIRM(Canceltxt, TRUE) THEN BEGIN
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.CancelEwBill(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     MESSAGE(EwayCanSucess);
//     //                     "E-Way Bill No." := '';
//     //                     "E-Way Bill Date" := 0DT;
//     //                     //"Sub Supply Type":="Sub Supply Type"::Supply;
//     //                     //"Update Vehicle Reason Remark":='';
//     //                     "Vehicle Type" := "Vehicle Type"::" ";
//     //                     //"Vehicle Update Reason":="Vehicle Update Reason"::"1";
//     //                     //"E-Way Bill Valid Upto":=0DT;
//     //                     MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += "No."
//     //                     ELSE BEGIN
//     //                         //   EwayServerErrorEntry(FALSE,"No.",Result,'','',EWayOperation::"Cancel EWB",USERID);
//     //                         ErrorText += "No.";
//     //                     END;
//     //                 //***
//     //             END;
//     //         END;
//     //     END;
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE('E-Way Bill No Not Cancelled ' + ErrorText + ' Please Check Error Log');
//     //     //Cancel E-Way for Purchase Return--
//     // end;


//     // procedure "ExtendE-WayBillSales"(RecSalesInv: Record "112")
//     // begin
//     //     /*
//     //     //Extend E-Way for Sales++
//     //     WITH RecSalesInv DO BEGIN
//     //         RecSalesInv.TESTFIELD("E-Way Bill No.");
//     //         RecSalesInv.TESTFIELD("Vehicle No.");
//     //         RecSalesInv.TESTFIELD("LR/RR No.");
//     //         RecSalesInv.TESTFIELD("LR/RR Date");
//     //         RecSalesInv.TESTFIELD("Remaining Distance");
//     //         reson:= "Vehicle Update Reason";
//     //         IF RecLocation.GET("Location Code") THEN BEGIN
//     //           IF Recstate.GET(State) THEN;
//     //           RecLocation.TESTFIELD("E-Invoice User ID");
//     //           RecLocation.TESTFIELD("E-Invoice Password");
//     //           Parameters:=Parameters.EWayBillParameters;
//     //           Parameters.CompanyName:=COMPANYNAME;
//     //           Parameters.InvoiceNo:="No.";
//     //           Parameters.TransactionType:='1';
//     //           Parameters.EWayBillDate:=FORMAT("E-Way Bill Date",30,'<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //           Parameters.EWayBillNo:="E-Way Bill No.";
//     //           Parameters.FromGstin:=RecLocation."GST Registration No.";
//     //           Parameters.VehicleNo:="Vehicle No.";
//     //           Parameters.FromPlace:=RecLocation.City;
//     //           Parameters.FromStateCode:=Recstate."State Code (GST Reg. No.)";
//     //           txtDistance:=FORMAT("Remaining Distance");
//     //           Parameters.RemainingDistance:=DELCHR(txtDistance,'=',',');
//     //           Parameters.TransDocNo:="LR/RR No.";
//     //           Parameters.TransDocDate:=FORMAT("LR/RR Date",10,'<Day,2>/<Month,2>/<Year4>');
//     //           Parameters.ExtensionRemarks:='test';//007
//     //           Parameters.ExtensionReasonCode:='1';//007
//     //           Parameters.TransMode:="Transport Method";
//     //           Parameters.AuidLoc:=RecLocation."E-Invoice User ID";
//     //           Parameters.AuPassLoc:=RecLocation."E-Invoice Password";
//     //           Parameters.UserId:=USERID;
//     //           IF CONFIRM(Extendtxt,TRUE) THEN BEGIN
//     //             EwayBillDLL:=EwayBillDLL.Nav;
//     //             Result:=EwayBillDLL.ExtendEwbValidity(Parameters);
//     //             //***
//     //             IF COPYSTR(Result,1,4)='True' THEN
//     //                MESSAGE(ExSucess)
//     //             ELSE  IF COPYSTR(Result,1,19)='ErrorFromNICServer-' THEN
//     //                ErrorText+=RecSalesInv."No."
//     //             ELSE BEGIN
//     //            // EwayServerErrorEntry(FALSE,RecSalesInv."No.",Result,'','',EWayOperation::"Extend Validity of EWB",USERID);
//     //             ErrorText+=RecSalesInv."No.";
//     //             END;
//     //               IF ErrorText<>'' THEN
//     //               MESSAGE(Text008,DELSTR(ErrorText,STRLEN(ErrorText)-1,STRLEN(ErrorText)));
//     //            //***
//     //           END;
//     //          END;
//     //     END;
//     //     //Extend E-Way for Sales--
//     //     */

//     // end;


//     // procedure "ExtendE-WayBillTransfer"(RecTransShipHeader: Record "5744")
//     // begin
//     //     /*
//     //     //Extend eWay for Transfer++
//     //     WITH RecTransShipHeader DO BEGIN
//     //         RecTransShipHeader.TESTFIELD("E-Way Bill No.");
//     //         RecTransShipHeader.TESTFIELD("Vehicle No.");
//     //         RecTransShipHeader.TESTFIELD("LR/RR No.");
//     //         RecTransShipHeader.TESTFIELD("LR/RR Date");
//     //         RecTransShipHeader.TESTFIELD("Remaining Distance");
//     //         reson:= "Vehicle Update Reason";
//     //         IF RecLocation.GET("Transfer-from Code") THEN BEGIN
//     //           RecLocation.TESTFIELD("E-Invoice User ID");
//     //           RecLocation.TESTFIELD("E-Invoice Password");
//     //           IF Recstate.GET(RecLocation."State Code") THEN;
//     //           Parameters:=Parameters.EWayBillParameters;
//     //           Parameters.CompanyName:=COMPANYNAME;
//     //           Parameters.InvoiceNo:="No.";
//     //           Parameters.TransactionType:='3';
//     //           Parameters.EWayBillDate:=FORMAT("E-Way Bill Date",30,'<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //           Parameters.EWayBillNo:="E-Way Bill No.";
//     //           Parameters.FromGstin:=RecLocation."GST Registration No.";
//     //           Parameters.VehicleNo:="Vehicle No.";
//     //           Parameters.FromPlace:=RecLocation.City;
//     //           Parameters.FromStateCode:=Recstate."State Code (GST Reg. No.)";
//     //           Parameters.RemainingDistance:=FORMAT("Remaining Distance");
//     //           Parameters.TransDocNo:="LR/RR No.";
//     //           Parameters.TransDocDate:=FORMAT("LR/RR Date",10,'<Day,2>/<Month,2>/<Year4>');
//     //           Parameters.ExtensionRemarks:='test';//007
//     //           Parameters.ExtensionReasonCode:='1';//007
//     //           Parameters.TransMode:="Transport Method";
//     //           Parameters.AuidLoc:=RecLocation."E-Invoice User ID";
//     //           Parameters.AuPassLoc:=RecLocation."E-Invoice Password";
//     //           Parameters.UserId:=USERID;
//     //           IF CONFIRM(Extendtxt,TRUE) THEN BEGIN
//     //             EwayBillDLL:=EwayBillDLL.Nav;
//     //             Result:=EwayBillDLL.ExtendEwbValidity(Parameters);
//     //             //***
//     //             IF COPYSTR(Result,1,4)='True' THEN
//     //                MESSAGE(ExSucess)
//     //             ELSE  IF COPYSTR(Result,1,19)='ErrorFromNICServer-' THEN
//     //                ErrorText+=RecTransShipHeader."No."
//     //             ELSE BEGIN
//     //          //   EwayServerErrorEntry(FALSE,RecTransShipHeader."No.",Result,'','',EWayOperation::"Extend Validity of EWB",USERID);
//     //             ErrorText+=RecTransShipHeader."No.";
//     //             END;
//     //               IF ErrorText<>'' THEN
//     //               MESSAGE(Text008,DELSTR(ErrorText,STRLEN(ErrorText)-1,STRLEN(ErrorText)));
//     //            //***
//     //           END;
//     //          END;
//     //     END;
//     //     //Extend eWay for Transfer--
//     //     */

//     // end;


//     // procedure "ExtendE-WayBillPurchaseReturn"(var RecPurchCrMemoHeader: Record "124")
//     // begin
//     //     /*
//     //     //Extend E-Way for Purchase Return++
//     //     WITH RecPurchCrMemoHeader DO BEGIN
//     //         TESTFIELD("E-Way Bill No.");
//     //         TESTFIELD("Vehicle No.");
//     //         TESTFIELD("LR/RR No.");
//     //         TESTFIELD("LR/RR Date");
//     //         TESTFIELD("Remaining Distance");
//     //         reson:= "Vehicle Update Reason";
//     //         IF RecLocation.GET("Location Code") THEN BEGIN
//     //           IF Recstate.GET(State) THEN;
//     //           RecLocation.TESTFIELD("E-Invoice User ID");
//     //           RecLocation.TESTFIELD("E-Invoice Password");
//     //           Parameters:=Parameters.EWayBillParameters;
//     //           Parameters.CompanyName:=COMPANYNAME;
//     //           Parameters.InvoiceNo:="No.";
//     //           Parameters.TransactionType:='4';
//     //           Parameters.EWayBillDate:=FORMAT("E-Way Bill Date",30,'<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //           Parameters.EWayBillNo:="E-Way Bill No.";
//     //           Parameters.FromGstin:=RecLocation."GST Registration No.";
//     //           Parameters.VehicleNo:="Vehicle No.";
//     //           Parameters.FromPlace:=RecLocation.City;
//     //           Parameters.FromStateCode:=Recstate."State Code (GST Reg. No.)";
//     //           txtDistance:=FORMAT("Remaining Distance");
//     //           Parameters.RemainingDistance:=DELCHR(txtDistance,'=',',');
//     //           Parameters.TransDocNo:="LR/RR No.";
//     //           Parameters.TransDocDate:=FORMAT("LR/RR Date",10,'<Day,2>/<Month,2>/<Year4>');
//     //           Parameters.ExtensionRemarks:='test';//007
//     //           Parameters.ExtensionReasonCode:='1';//007
//     //           Parameters.TransMode:="Transport Method";
//     //           Parameters.AuidLoc:=RecLocation."E-Invoice User ID";
//     //           Parameters.AuPassLoc:=RecLocation."E-Invoice Password";
//     //           Parameters.UserId:=USERID;
//     //           IF CONFIRM(Extendtxt,TRUE) THEN BEGIN
//     //             EwayBillDLL:=EwayBillDLL.Nav;
//     //             Result:=EwayBillDLL.ExtendEwbValidity(Parameters);
//     //             //***
//     //             IF COPYSTR(Result,1,4)='True' THEN
//     //                MESSAGE(ExSucess)
//     //             ELSE  IF COPYSTR(Result,1,19)='ErrorFromNICServer-' THEN
//     //                ErrorText+="No."
//     //             ELSE BEGIN
//     //          //   EwayServerErrorEntry(FALSE,"No.",Result,'','',EWayOperation::"Extend Validity of EWB",USERID);
//     //             ErrorText+="No.";
//     //             END;
//     //               IF ErrorText<>'' THEN
//     //               MESSAGE(Text008,DELSTR(ErrorText,STRLEN(ErrorText)-1,STRLEN(ErrorText)));
//     //            //***
//     //           END;
//     //          END;
//     //     END;
//     //     //Extend E-Way for Purchase Return--
//     //     */

//     // end;


//     procedure UpdateTransporterlSales(RecSalesInv: Record 112)
//     begin
//         /*
//         //Update Tranaporter E-Way for Sales++
//         WITH RecSalesInv DO BEGIN
//             RecSalesInv.TESTFIELD("E-Way Bill No.");
//             RecSalesInv.TESTFIELD("Vehicle No.");
//             RecSalesInv.TESTFIELD("LR/RR No.");
//             RecSalesInv.TESTFIELD("LR/RR Date");
//              reson:= "Vehicle Update Reason";
//             IF RecLocation.GET("Location Code") THEN BEGIN
//               RecLocation.TESTFIELD("E-Invoice User ID");
//               RecLocation.TESTFIELD("E-Invoice Password");
//               IF Recstate.GET(State) THEN;
//               Parameters:=Parameters.EWayBillParameters;
//               Parameters.CompanyName:=COMPANYNAME;
//               Parameters.InvoiceNo:="No.";
//               Parameters.TransactionType:='1';
//               Parameters.FromGstin:=RecLocation."GST Registration No.";
//               Parameters.EWayBillDate:=FORMAT("E-Way Bill Date",30,'<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//               Parameters.EWayBillNo:="E-Way Bill No.";
//               Parameters.TransporterId:='01AVIPR7739L1Z2';//007
//               Parameters.AuidLoc:=RecLocation."E-Invoice User ID";
//               Parameters.AuPassLoc:=RecLocation."E-Invoice Password";
//               Parameters.UserId:=USERID;
//               IF CONFIRM(Updatetranstxt,TRUE) THEN BEGIN
//                 EwayBillDLL:=EwayBillDLL.Nav;
//                 Result:=EwayBillDLL.UpdateTransporter(Parameters);
//                 MESSAGE(Result);
//               END;
//            END;
//         END;
//         //Update Tranaporter for Sales--
//         */

//     end;


//     procedure UpdateTransporterTransfer(RecTransShipHeader: Record 5744)
//     begin
//         /*
//         //Update Tranaporter for Transfer++
//         WITH RecTransShipHeader DO BEGIN
//             RecTransShipHeader.TESTFIELD("E-Way Bill No.");
//             RecTransShipHeader.TESTFIELD("Vehicle No.");
//             RecTransShipHeader.TESTFIELD("LR/RR No.");
//             RecTransShipHeader.TESTFIELD("LR/RR Date");
//             reson:= "Vehicle Update Reason";
//             IF RecLocation.GET("Transfer-from Code") THEN BEGIN
//               IF Recstate.GET(RecLocation."State Code") THEN;
//               RecLocation.TESTFIELD("E-Invoice User ID");
//               RecLocation.TESTFIELD("E-Invoice Password");
//               EwayBillDLL:=EwayBillDLL.Nav;
//               Parameters.CompanyName:=COMPANYNAME;
//               Parameters.InvoiceNo:="No.";
//               Parameters.TransactionType:='3';
//               Parameters.FromGstin:=RecLocation."GST Registration No.";
//               Parameters.EWayBillDate:=FORMAT("E-Way Bill Date",30,'<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//               Parameters.EWayBillNo:="E-Way Bill No.";
//               Parameters.AuidLoc:=RecLocation."E-Invoice User ID";
//               Parameters.AuPassLoc:=RecLocation."E-Invoice Password";
//               Parameters.UserId:=USERID;
//               Parameters.TransporterId:='01AVIPR7739L1Z2';//007
//               Result:=EwayBillDLL.UpdateTransporter(Parameters);
//               MESSAGE(Result);
//            END;
//         END;
//         //Update Transpoter for Transfer--
//         */

//     end;


//     procedure ValidateCustomerGSTIN(GSTIN: Code[20])
//     begin
//         /*
//         //Validate Customer++
//         IF RecCompanyInfo.GET THEN;
//           RecCompanyInfo.TESTFIELD("E-Invoice User ID");
//           RecCompanyInfo.TESTFIELD("E-Invoice Password");
//           RecCompanyInfo.TESTFIELD("GST Registration No.");
//           EwayBillDLL:=EwayBillDLL.Nav;
//           Parameters:=Parameters.EWayBillParameters;
//           Parameters.CompanyName:=COMPANYNAME;
//           Parameters.FromGstin:=RecCompanyInfo."GST Registration No.";
//           Parameters.CustomerGstin:=GSTIN;
//           Parameters.AuidLoc:=RecCompanyInfo."E-Invoice User ID";
//           Parameters.AuPassLoc:=RecCompanyInfo."E-Invoice Password";
//           Parameters.UserId:=USERID;
//           Result:=EwayBillDLL.GetGstnDetails(Parameters);
//           MESSAGE(Result);
//          //Validate Customer--
//          */

//     end;


//     procedure ValidateHSN(HsnCode: Code[20])
//     begin
//         /*
//         //Validate HSN
//         IF RecCompanyInfo.GET THEN;
//         RecCompanyInfo.TESTFIELD("E-Invoice User ID");
//         RecCompanyInfo.TESTFIELD("E-Invoice Password");
//         RecCompanyInfo.TESTFIELD("GST Registration No.");
//         EwayBillDLL:=EwayBillDLL.Nav;
//         Parameters:=Parameters.EWayBillParameters;
//         Parameters.CompanyName:=COMPANYNAME;
//         Parameters.FromGstin:=RecCompanyInfo."GST Registration No.";
//         Parameters.HsnCode:=HsnCode;
//         Parameters.AuidLoc:=RecCompanyInfo."E-Invoice User ID";
//         Parameters.AuPassLoc:=RecCompanyInfo."E-Invoice Password";
//         Parameters.UserId:=USERID;
//         Result:=EwayBillDLL.HsnDetails(Parameters);
//         MESSAGE(Result);
//          //Validate HSN--
//          */

//     end;


//     // procedure PrintEwayBillSales(eWayBillNo: Code[20]; FromGstin: Code[20]; APIID: Text[30]; APIPassword: Text[30])
//     // begin
//     //     CLEAR(EwayBillDLL);
//     //     RecGeneLedSetup.GET;
//     //     RecGeneLedSetup.TESTFIELD("E-Way Document Store Path");
//     //     Parameters := Parameters.EWayBillParameters;
//     //     Parameters.CompanyName := COMPANYNAME;
//     //     Parameters.EWayBillNo := eWayBillNo;
//     //     Parameters.FromGstin := FromGstin;
//     //     Parameters.AuidLoc := APIID;
//     //     Parameters.AuPassLoc := APIPassword;
//     //     Parameters.UserId := USERID;
//     //     Parameters.FilePath := RecGeneLedSetup."E-Way Document Store Path";
//     //     EwayBillDLL := EwayBillDLL.Nav;
//     //     EwayBillDLL.PrintEwb(Parameters);
//     //     OPFile := RecGeneLedSetup."E-Way Document Store Path" + eWayBillNo + '.pdf';
//     //     LocalPathAndFileName := FileManagement.SaveFileDialog('Save', 'Eway' + DELCHR(eWayBillNo, '=', '/') + '.pdf', 'pdf files *.pdf|*.pdf');
//     //     IF LocalPathAndFileName <> '' THEN
//     //         FileManagement.DownloadToFile(OPFile, LocalPathAndFileName);
//     // end;

//     local procedure "***************** Bulk eWay Generation Sales*******************"()
//     begin
//     end;


//     procedure GetDistance(var RecSIH: Record 112; TransportMethod: Code[20])
//     var
//         origin: Code[20];
//         dest: Code[20];
//         DistOuptput: Decimal;
//         RecTransportMethod: Record 259;
//     begin
//         REPEAT
//         //     IF RecLocation.GET(RecSIH."Location Code") THEN;
//         //     RecLocation.TESTFIELD("Post Code");
//         //     RecSIH.TESTFIELD("Ship-to Post Code");
//         //     EVALUATE(origin, RecLocation."Post Code");
//         //     EVALUATE(dest, RecSIH."Ship-to Post Code");
//         //     IF RecTransportMethod.GET(TransportMethod) THEN;
//         //     RecTransportMethod.TESTFIELD(RecTransportMethod.Description);
//         //     EwayBillDLL := EwayBillDLL.Nav;
//         //     // DistOuptput:=EwayBillDLL.GetDistance(origin,dest,RecTransportMethod.Description);
//         //     RecSIH.Distance := DistOuptput;
//         //     RecSIH."Transport Method" := TransportMethod;
//         //     RecSIH.MODIFY;
//         // UNTIL RecSIH.NEXT = 0;
//     end;


//     procedure UpdateVehicleDetails(var RecSalesInv: Record 112; VehicleNo: Code[20]; LRNo: Code[20]; LRDate: Date; VehicleType: Option " ",Regular,ODC; SupplyType: Option " ",Supply,Export,"For Own Use",Others,"Exhibition or Fairs"; TransportMethod: Code[20])
//     begin
//         // WITH RecSalesInv DO BEGIN
//         //     "Vehicle No." := VehicleNo;
//         //     "LR/RR No." := LRNo;
//         //     "LR/RR Date" := LRDate;
//         //     "Vehicle Type" := VehicleType;
//         //     //  "Sub Supply Type":=SupplyType;
//         //     //"Sub-Type":=SupplyType;
//         //     "Transport Method" := TransportMethod;
//         //     MODIFY;
//         END;
//     end;


//     // procedure "Bulk E-WayBillGeneration"(var RecSIH: Record 112; Print: Boolean)
//     // var
//     //     RecSInvL: Record 113;
//     // begin
//     //     //Generate eWay Bill No. for Sales++
//     //     ErrorText := '';
//     //     SuccessText := '';
//     //     VARVehicleType := RecSIH."Vehicle Type";

//     //     RecLocation.GET(RecSIH."Location Code");
//     //     RecLocation.TESTFIELD("GST Registration No.");
//     //     RecLocation.TESTFIELD("E-Invoice User ID");
//     //     RecLocation.TESTFIELD("E-Invoice Password");
//     //     EwayBillDLL := EwayBillDLL.Nav;
//     //     //IF ISNULL(ewbSession) THEN;
//     //     //ewbSession := EwayBillDLL.GetAuthToken(COMPANYNAME,RecLocation."GST Registration No.", RecLocation."E-Invoice User ID", RecLocation."E-Invoice Password",USERID).Result; // Get Authentication Token

//     //     REPEAT
//     //         RecGeneLedSetup.GET;
//     //         RecSIH.CALCFIELDS("Amount to Customer");
//     //         IF (RecSIH."Amount to Customer" >= RecGeneLedSetup."E-Way Amount Limit") AND (RecSIH.Distance >= RecGeneLedSetup."E-Way Distance Limit") THEN BEGIN
//     //             RecSIH.TESTFIELD("E-Way Bill No.", '');
//     //             RecSIH.TESTFIELD("Posting Date");
//     //             //RecSIH.TESTFIELD("Location GST Reg. No.");
//     //             // RecSIH.TESTFIELD("Customer GST Reg. No.");
//     //             RecSIH.TESTFIELD("Location Code");
//     //             RecSIH.TESTFIELD("Sell-to Post Code");
//     //             //RecSIH.TESTFIELD("GST Ship-to State Code");
//     //             RecSIH.TESTFIELD("GST Bill-to State Code");
//     //             // RecSIH.TESTFIELD(Distance);
//     //             RecSIH.TESTFIELD("Vehicle No.");
//     //             RecSIH.TESTFIELD("LR/RR No.");
//     //             RecSIH.TESTFIELD("LR/RR Date");
//     //             RecSInvL.RESET;
//     //             RecSInvL.SETRANGE("Document No.", RecSIH."No.");
//     //             RecSInvL.SETRANGE(Type, RecSInvL.Type::Item);
//     //             IF RecSInvL.FINDSET THEN
//     //                 REPEAT
//     //                     RecSInvL.TESTFIELD(RecSInvL."HSN/SAC Code")
//     //                 UNTIL RecSInvL.NEXT = 0;
//     //             RecLocation.GET(RecSIH."Location Code");
//     //             RecLocation.TESTFIELD("Post Code");
//     //             RecLocation.TESTFIELD("GST Registration No.");
//     //             RecLocation.TESTFIELD("State Code");
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");
//     //             EwayBillDLL := EwayBillDLL.Nav;
//     //             Test := EwayBillDLL.GenEwBillForSales(RecSIH."No.", COMPANYNAME, 'O', '1', 'INV', 1, '', RecLocation."E-Invoice User ID", RecLocation."E-Invoice Password", USERID, FORMAT(VARVehicleType));

//     //             IF Print THEN
//     //                 PrintEwayBillSales(RecSIH."E-Way Bill No.", RecLocation."GST Registration No.", RecLocation."E-Invoice User ID", RecLocation."E-Invoice Password");
//     //             IF COPYSTR(Test, 1, 10) = 'E-Way Bill' THEN
//     //                 SuccessText := Text002
//     //             ELSE
//     //                 IF COPYSTR(Test, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                     ErrorText += RecSIH."No."
//     //                 ELSE BEGIN
//     //                     EwayServerErrorEntry(FALSE, RecSIH."No.", Test, '', '', EWayOperation::"Generate EWB", USERID);
//     //                     ErrorText += RecSIH."No.";
//     //                 END;
//     //         END ELSE
//     //             ERROR('Check E-Way Amount and E-Way Distance Limit in General Ledger Setup');

//     //     UNTIL RecSIH.NEXT = 0;

//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text001, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);

//     //     //Generate eWay Bill No. for Sales--
//     // end;


//     // procedure "Bulk E-WayUpdteVehicleNoSales"(var RecSalesInv: Record "112"; UpdateVehicleReasonRemark: Text[50]; VehicleUpdateReason: Option "1","2","3","4"; newvehicleno: Code[20])
//     // var
//     //     CommaCount: Integer;
//     //     TotalStrCount: Integer;
//     //     I: Integer;
//     //     SeparateString: Text;
//     // begin
//     //     //Update Vehicle No. For Sales++
//     //     errormsg := '';
//     //     WITH RecSalesInv DO BEGIN
//     //         VARVehicleType := "Vehicle Type";
//     //         REPEAT
//     //             RecSalesInv.TESTFIELD("E-Way Bill No.");
//     //             RecSalesInv.TESTFIELD("Vehicle No.");
//     //             RecSalesInv.TESTFIELD("LR/RR No.");
//     //             RecSalesInv.TESTFIELD("LR/RR Date");

//     //             IF RecLocation.GET("Location Code") THEN BEGIN
//     //                 RecLocation.TESTFIELD("E-Invoice User ID");
//     //                 RecLocation.TESTFIELD("E-Invoice Password");
//     //                 IF Recstate.GET(State) THEN;
//     //                 Parameters := Parameters.EWayBillParameters;
//     //                 Parameters.CompanyName := COMPANYNAME;
//     //                 Parameters.FromGstin := RecLocation."GST Registration No.";
//     //                 Parameters.EWayBillNo := "E-Way Bill No.";
//     //                 Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //                 Parameters.VehicleNo := "Vehicle No.";
//     //                 Parameters.FromPlace := RecLocation.City;
//     //                 Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //                 Parameters.ReasonCode := FORMAT(VehicleUpdateReason);
//     //                 // Parameters.Remarks:="Update Vehicle Reason Remark";
//     //                 Parameters.TransDocNo := "LR/RR No.";
//     //                 Parameters.TransDocDate := FORMAT("LR/RR Date", 10, '<Day,2>/<Month,2>/<Year4>');
//     //                 Parameters.TransMode := "Transport Method";
//     //                 Parameters.VehicleType := FORMAT(VARVehicleType);
//     //                 Parameters.InvoiceNo := "No.";
//     //                 Parameters.TransactionType := '1';
//     //                 Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //                 Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //                 Parameters.UserId := USERID;
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.UpdateVehicleNo(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     SuccessText := VehSucess;
//     //                     //  RecSalesInv."Update Vehicle Reason Remark":=UpdateVehicleReasonRemark;
//     //                     //  RecSalesInv."Vehicle Update Reason":=VehicleUpdateReason;
//     //                     RecSalesInv."Vehicle No." := newvehicleno;
//     //                     RecSalesInv.MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += RecSalesInv."No."
//     //                     ELSE BEGIN
//     //                         EwayServerErrorEntry(FALSE, RecSalesInv."No.", Result, '', '', EWayOperation::"Update Vehicle No.", USERID);
//     //                         ErrorText += RecSalesInv."No.";
//     //                     END;
//     //                 //**
//     //             END;
//     //         UNTIL RecSalesInv.NEXT = 0;
//     //     END;
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text005, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);
//     //     //Update Vehicle No. For Sales--
//     // end;


//     // procedure "Bulk CancelE-WayBillSales"(var RecSalesInv: Record "112"; CancelRemark: Text[50]; CancelReasonCode: Option "0","1","2","3","4")
//     // begin
//     //     //Cancel E-Way for Sales++
//     //     errormsg := '';
//     //     reson := CancelReasonCode;
//     //     WITH RecSalesInv DO BEGIN
//     //         REPEAT
//     //             RecSalesInv.TESTFIELD("E-Way Bill No.");
//     //             RecSalesInv.TESTFIELD("Vehicle No.");
//     //             RecSalesInv.TESTFIELD("LR/RR No.");
//     //             RecSalesInv.TESTFIELD("LR/RR Date");
//     //             IF RecLocation.GET("Location Code") THEN BEGIN
//     //                 IF Recstate.GET(State) THEN;
//     //                 RecLocation.TESTFIELD("E-Invoice User ID");
//     //                 RecLocation.TESTFIELD("E-Invoice Password");
//     //                 Parameters := Parameters.EWayBillParameters;
//     //                 Parameters.CompanyName := COMPANYNAME;
//     //                 Parameters.FromGstin := RecLocation."GST Registration No.";
//     //                 Parameters.TransactionType := '1';
//     //                 Parameters.CancelRemarks := "Cancel Remark";
//     //                 Parameters.CancelReasonCode := FORMAT(reson);
//     //                 Parameters.EWayBillNo := "E-Way Bill No.";
//     //                 Parameters.InvoiceNo := "No.";
//     //                 Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //                 Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //                 Parameters.UserId := USERID;
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.CancelEwBill(Parameters);
//     //                 //**
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     SuccessText := EwayCanSucess;
//     //                     "E-Way Bill No." := '';
//     //                     "E-Way Bill Date" := 0DT;
//     //                     //"Sub Supply Type":="Sub Supply Type"::Supply;
//     //                     //"Sub-Type":="Sub-Type"::Supply;
//     //                     //"Update Vehicle Reason Remark":='';
//     //                     "Vehicle Type" := "Vehicle Type"::" ";
//     //                     // "Vehicle Update Reason":="Vehicle Update Reason"::"0";
//     //                     //"E-Way Bill Valid Upto":=0DT;
//     //                     "Cancel Reason Code" := CancelReasonCode;
//     //                     "Cancel Remark" := CancelRemark;
//     //                     MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += RecSalesInv."No."
//     //                     ELSE BEGIN
//     //                         EwayServerErrorEntry(FALSE, RecSalesInv."No.", Result, '', '', EWayOperation::"Cancel EWB", USERID);
//     //                         ErrorText += RecSalesInv."No.";
//     //                     END;
//     //                 //**
//     //             END;
//     //         UNTIL RecSalesInv.NEXT = 0;
//     //     END;
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text009, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);
//     //     //Cancel E-Way for Sales--
//     // end;


//     // procedure "BulkExtendE-WayBillSales"(var RecSalesInv: Record "112"; RemainingDistance: Decimal)
//     // begin
//     //     //Extend E-Way for Sales++
//     //     WITH RecSalesInv DO BEGIN
//     //         REPEAT
//     //             RecSalesInv.TESTFIELD("E-Way Bill No.");
//     //             RecSalesInv.TESTFIELD("Vehicle No.");
//     //             RecSalesInv.TESTFIELD("LR/RR No.");
//     //             RecSalesInv.TESTFIELD("LR/RR Date");
//     //             // reson:= "Vehicle Update Reason";
//     //             IF RecLocation.GET("Location Code") THEN BEGIN
//     //                 IF Recstate.GET(State) THEN;
//     //                 RecLocation.TESTFIELD("E-Invoice User ID");
//     //                 RecLocation.TESTFIELD("E-Invoice Password");
//     //                 Parameters := Parameters.EWayBillParameters;
//     //                 Parameters.CompanyName := COMPANYNAME;
//     //                 Parameters.InvoiceNo := "No.";
//     //                 Parameters.TransactionType := '1';
//     //                 Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //                 Parameters.EWayBillNo := "E-Way Bill No.";
//     //                 Parameters.FromGstin := RecLocation."GST Registration No.";
//     //                 Parameters.VehicleNo := "Vehicle No.";
//     //                 Parameters.FromPlace := RecLocation.City;
//     //                 Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //                 txtDistance := FORMAT(RemainingDistance);
//     //                 Parameters.RemainingDistance := DELCHR(txtDistance, '=', ',');
//     //                 Parameters.TransDocNo := "LR/RR No.";
//     //                 Parameters.TransDocDate := FORMAT("LR/RR Date", 10, '<Day,2>/<Month,2>/<Year4>');
//     //                 Parameters.ExtensionRemarks := 'test';//007
//     //                 Parameters.ExtensionReasonCode := '1';//007
//     //                 Parameters.TransMode := "Transport Method";
//     //                 Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //                 Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //                 Parameters.UserId := USERID;
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.ExtendEwbValidity(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     SuccessText := ExSucess;
//     //                     //"Remaining Distance":=RemainingDistance;
//     //                     // MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += RecSalesInv."No."
//     //                     ELSE BEGIN
//     //                         EwayServerErrorEntry(FALSE, RecSalesInv."No.", Result, '', '', EWayOperation::"Extend Validity of EWB", USERID);
//     //                         ErrorText += RecSalesInv."No.";
//     //                     END;
//     //             END;
//     //         //***
//     //         UNTIL RecSalesInv.NEXT = 0;
//     //     END;
//     //     //Extend E-Way for Sales--
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text008, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);
//     // end;


//     // procedure "Bulk E-WayBillGenerationandPrint"(var RecSIH: Record "112")
//     // var
//     //     RecSInvL: Record "113";
//     // begin
//     //     //Generate eWay Bill No. for Sales++
//     //     REPEAT
//     //         RecGeneLedSetup.GET;
//     //         RecSIH.CALCFIELDS("Amount to Customer");
//     //         IF (RecSIH."Amount to Customer" >= RecGeneLedSetup."E-Way Amount Limit") AND (RecSIH.Distance >= RecGeneLedSetup."E-Way Distance Limit") THEN BEGIN
//     //             RecSIH.TESTFIELD("Posting Date");
//     //             // RecSIH.TESTFIELD("Location GST Reg. No.");
//     //             //RecSIH.TESTFIELD("Customer GST Reg. No.");
//     //             RecSIH.TESTFIELD("Location Code");
//     //             RecSIH.TESTFIELD("Sell-to Post Code");
//     //             //RecSIH.TESTFIELD("GST Ship-to State Code");
//     //             RecSIH.TESTFIELD("GST Bill-to State Code");
//     //             // RecSIH.TESTFIELD(Distance);
//     //             RecSIH.TESTFIELD("Vehicle No.");
//     //             RecSIH.TESTFIELD("LR/RR No.");
//     //             RecSIH.TESTFIELD("LR/RR Date");
//     //             RecSInvL.RESET;
//     //             RecSInvL.SETRANGE("Document No.", RecSIH."No.");
//     //             RecSInvL.SETRANGE(Type, RecSInvL.Type::Item);
//     //             IF RecSInvL.FINDSET THEN
//     //                 REPEAT
//     //                     RecSInvL.TESTFIELD(RecSInvL."HSN/SAC Code")
//     //                 UNTIL RecSInvL.NEXT = 0;
//     //             RecLocation.GET(RecSIH."Location Code");
//     //             RecLocation.TESTFIELD("Post Code");
//     //             RecLocation.TESTFIELD("GST Registration No.");
//     //             RecLocation.TESTFIELD("State Code");
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");
//     //             EwayBillDLL := EwayBillDLL.Nav;
//     //             //  Test:=EwayBillDLL.GenEwBillForSales(RecSIH."No.",COMPANYNAME,'O','1','INV','',RecLocation."E-Invoice User ID",RecLocation."E-Invoice Password",USERID);
//     //             MESSAGE(Test);
//     //             PrintEwayBillSales(RecSIH."E-Way Bill No.", RecLocation."GST Registration No.", RecLocation."E-Invoice User ID", RecLocation."E-Invoice Password");
//     //         END ELSE
//     //             ERROR('Check E-Way Amount and E-Way Distance Limit in General Ledger Setup');
//     //     UNTIL RecSIH.NEXT = 0;
//     //     //Generate eWay Bill No. for Sales--
//     // end;


//     // procedure ConsolidatedEWayBill(var RecSalesInv: Record "112")
//     // begin
//     //     //E-Way Bill Consolidated ++
//     //     WITH RecSalesInv DO BEGIN
//     //         CLEAR(ewayno);
//     //         REPEAT
//     //             TESTFIELD("E-Way Bill No.");
//     //             TESTFIELD("Vehicle No.");
//     //             TESTFIELD("LR/RR No.");
//     //             TESTFIELD("LR/RR Date");
//     //             IF RecLocation.GET("Location Code") THEN;
//     //             IF Recstate.GET(State) THEN;
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");
//     //             ewayno += RecSalesInv."E-Way Bill No." + '|';
//     //         UNTIL RecSalesInv.NEXT = 0;
//     //         Parameters := Parameters.EWayBillParameters;
//     //         Parameters.CompanyName := COMPANYNAME;
//     //         Parameters.TransactionType := '1';
//     //         Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //         Parameters.FromGstin := RecLocation."GST Registration No.";
//     //         Parameters.FromPincode := RecLocation."Post Code";
//     //         Parameters.InvoiceNo := "No.";
//     //         Parameters.VehicleNo := "Vehicle No.";
//     //         Parameters.FromPlace := RecLocation.City;
//     //         Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //         Parameters.TransDocNo := "LR/RR No.";
//     //         Parameters.TransDocDate := FORMAT("LR/RR Date", 10, '<Day,2>/<Month,2>/<Year4>');
//     //         Parameters.TransMode := "Transport Method";
//     //         Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //         Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //         Parameters.UserId := USERID;
//     //         Parameters.EWayBillNo := DELCHR(ewayno, '>', '|');
//     //         EwayBillDLL := EwayBillDLL.Nav;
//     //         Result := EwayBillDLL.GenerateCewbill(Parameters);
//     //         MESSAGE(Result);
//     //     END;
//     //     //E-Way Bill Consolidated --
//     // end;

//     // local procedure "************Bulk eWay Generation Transfer***********************"()
//     // begin
//     // end;


//     // procedure GetDistanceTrans(var RecTSH: Record "5744"; TransportMethod: Code[20])
//     // var
//     //     origin: Code[20];
//     //     dest: Code[20];
//     //     DistOuptput: Decimal;
//     //     RecTransportMethod: Record "259";
//     // begin
//     //     REPEAT
//     //         IF RecLocation.GET(RecTSH."Transfer-from Code") THEN;
//     //         RecLocation.TESTFIELD("Post Code");
//     //         IF RecLoc.GET(RecTSH."Transfer-to Code") THEN;
//     //         EVALUATE(origin, RecLocation."Post Code");
//     //         EVALUATE(dest, RecLoc."Post Code");
//     //         IF RecTransportMethod.GET(TransportMethod) THEN;
//     //         RecTransportMethod.TESTFIELD(RecTransportMethod.Description);
//     //         EwayBillDLL := EwayBillDLL.Nav;
//     //         // DistOuptput:=EwayBillDLL.GetDistance(origin,dest,RecTransportMethod.Description);
//     //         RecTSH.Distance := DistOuptput;
//     //         RecTSH."Transport Method" := TransportMethod;
//     //         RecTSH.MODIFY;
//     //     UNTIL RecTSH.NEXT = 0;
//     // end;


//     // procedure UpdateVehicleDetailsTrans(var RecTSH: Record "5744"; VehicleNo: Code[20]; LRNo: Code[20]; LRDate: Date; VehicleType: Option " ",Regular,ODC; SupplyType: Option " ",Supply,Export,"For Own Use",Others,"Exhibition or Fairs")
//     // begin
//     //     WITH RecTSH DO BEGIN
//     //         "Vehicle No." := VehicleNo;
//     //         "LR/RR No." := LRNo;
//     //         "LR/RR Date" := LRDate;
//     //         "Vehicle Type" := VehicleType;
//     //         //"Sub Supply Type":=SupplyType;
//     //         MODIFY;
//     //     END;
//     // end;


//     // procedure "Bulk E-WayBillGenerationTrans"(var RecTSH: Record "5744"; Print: Boolean)
//     // var
//     //     RecSInvL: Record "113";
//     // begin
//     //     //Generate eWay Bill No. for Transfer++
//     //     ErrorText := '';
//     //     SuccessText := '';
//     //     VARVehicleType := RecTSH."Vehicle Type";
//     //     REPEAT
//     //         RecGeneLedSetup.GET;
//     //         // RecTSH.CALCFIELDS("Total  Line Amount");
//     //         // IF (RecTSH."Total  Line Amount" >=RecGeneLedSetup."E-Way Amount Limit") AND (
//     //         IF RecTSH.Distance >= RecGeneLedSetup."E-Way Distance Limit" THEN BEGIN
//     //             RecTSH.TESTFIELD("E-Way Bill No.", '');
//     //             RecTSH.TESTFIELD("Posting Date");
//     //             // RecTSH.TESTFIELD(Distance);
//     //             RecTSH.TESTFIELD("Vehicle No.");
//     //             RecTSH.TESTFIELD("LR/RR No.");
//     //             RecTSH.TESTFIELD("LR/RR Date");
//     //             RecTSH.TESTFIELD("LR/RR Date");
//     //             RecLoc.GET(RecTSH."Transfer-from Code");
//     //             RecLoc.TESTFIELD("Post Code");
//     //             RecLoc.TESTFIELD("GST Registration No.");
//     //             RecLoc.TESTFIELD("State Code");
//     //             RecLoc.TESTFIELD("E-Invoice User ID");
//     //             RecLoc.TESTFIELD("E-Invoice Password");
//     //             RecLocDest.GET(RecTSH."Transfer-to Code");
//     //             RecLocDest.TESTFIELD("Post Code");
//     //             RecLocDest.TESTFIELD("GST Registration No.");
//     //             RecLocDest.TESTFIELD("State Code");
//     //             RecTSL.RESET;
//     //             RecTSL.SETRANGE("Document No.", RecTSH."No.");
//     //             RecTSL.SETFILTER("Item No.", '<>%1', '');
//     //             IF RecTSL.FINDSET THEN
//     //                 REPEAT
//     //                     RecTSL.TESTFIELD(RecTSL."HSN/SAC Code")
//     //                 UNTIL RecTSL.NEXT = 0;
//     //             RecLoc.TESTFIELD("E-Invoice User ID");
//     //             RecLoc.TESTFIELD("E-Invoice Password");
//     //             EwayBillDLL := EwayBillDLL.Nav;
//     //             // Test:=EwayBillDLL.GenEwBillForTransfers(RecTSH."No.",COMPANYNAME,'O','3','CHL','',RecLoc."E-Invoice User ID",RecLoc."E-Invoice Password",USERID);
//     //             // IF Print THEN
//     //             //Test:=EwayBillDLL.GenEwBillForTransfers(RecTSH."No.",COMPANYNAME,'O','3','CHL','',RecLoc."E-Invoice User ID",RecLoc."E-Invoice Password",USERID);
//     //             IF COPYSTR(Test, 1, 10) = 'E-Way Bill' THEN
//     //                 SuccessText := Text002
//     //             ELSE
//     //                 IF COPYSTR(Test, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                     ErrorText += RecTSH."No."
//     //                 ELSE BEGIN
//     //                     EwayServerErrorEntry(FALSE, RecTSH."No.", Test, '', '', EWayOperation::"Generate EWB", USERID);
//     //                     ErrorText += RecTSH."No.";
//     //                 END;
//     //         END ELSE
//     //             ERROR('Check E-Way Amount and E-Way Distance Limit in General Ledger Setup');

//     //     UNTIL RecTSH.NEXT = 0;

//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text001, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);

//     //     //Generate eWay Bill No. for Transfer--
//     // end;


//     // procedure "Bulk E-WayUpdteVehicleNoTransfer"(var RecTransShipHeader: Record "5744"; UpdateVehicleReasonRemark: Text[50]; VehicleUpdateReason: Option "1","2","3","4"; newvehicleno: Code[20])
//     // var
//     //     CommaCount: Integer;
//     //     TotalStrCount: Integer;
//     //     I: Integer;
//     //     SeparateString: Text;
//     // begin
//     //     //Update Vehicle No. for Transfer++
//     //     errormsg := '';
//     //     WITH RecTransShipHeader DO BEGIN
//     //         VARVehicleType := "Vehicle Type";
//     //         REPEAT
//     //             RecTransShipHeader.TESTFIELD("E-Way Bill No.");
//     //             RecTransShipHeader.TESTFIELD("Vehicle No.");
//     //             RecTransShipHeader.TESTFIELD("LR/RR No.");
//     //             RecTransShipHeader.TESTFIELD("LR/RR Date");
//     //             // TESTFIELD("Update Vehicle Reason Remark");
//     //             TESTFIELD("Vehicle Type");
//     //             VARVehicleType := "Vehicle Type";
//     //             // reson:= "Vehicle Update Reason";
//     //             IF RecLocation.GET("Transfer-from Code") THEN BEGIN
//     //                 IF Recstate.GET(RecLocation."State Code") THEN;
//     //                 RecLocation.TESTFIELD("E-Invoice User ID");
//     //                 RecLocation.TESTFIELD("E-Invoice Password");
//     //                 Parameters := Parameters.EWayBillParameters;
//     //                 Parameters.CompanyName := COMPANYNAME;
//     //                 Parameters.FromGstin := RecLocation."GST Registration No.";
//     //                 Parameters.EWayBillNo := "E-Way Bill No.";
//     //                 Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //                 Parameters.VehicleNo := "Vehicle No.";
//     //                 Parameters.FromPlace := RecLocation.City;
//     //                 Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //                 Parameters.ReasonCode := FORMAT(reson);
//     //                 Parameters.Remarks := '';//"Update Vehicle Reason Remark";
//     //                 Parameters.TransDocNo := "LR/RR No.";
//     //                 Parameters.TransDocDate := FORMAT("LR/RR Date", 10, '<Day,2>/<Month,2>/<Year4>');
//     //                 Parameters.TransMode := "Transport Method";
//     //                 Parameters.VehicleType := FORMAT(VARVehicleType);
//     //                 Parameters.InvoiceNo := "No.";
//     //                 Parameters.TransactionType := '3';
//     //                 Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //                 Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //                 Parameters.UserId := USERID;
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.UpdateVehicleNo(Parameters);
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     SuccessText := VehSucess;
//     //                     //"Update Vehicle Reason Remark":='';//UpdateVehicleReasonRemark;
//     //                     //"Vehicle Update Reason":=VehicleUpdateReason;
//     //                     "Vehicle No." := newvehicleno;
//     //                     MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += "No."
//     //                     ELSE BEGIN
//     //                         EwayServerErrorEntry(FALSE, "No.", Result, '', '', EWayOperation::"Update Vehicle No.", USERID);
//     //                         ErrorText += "No.";
//     //                     END;
//     //             END;
//     //         UNTIL NEXT = 0;
//     //     END;
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text005, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);
//     //     //Update Vehicle No. For Transfer--
//     // end;


//     // procedure "Bulk CancelE-WayBillTransfer"(var RecTransShipHeader: Record "5744"; CancelRemark: Text[50]; CancelReasonCode: Option "0","1","2","3","4")
//     // begin
//     //     //Cancel E-Way for Transfer++
//     //     errormsg := '';
//     //     reson := CancelReasonCode;
//     //     WITH RecTransShipHeader DO BEGIN
//     //         REPEAT
//     //             RecTransShipHeader.TESTFIELD("E-Way Bill No.");
//     //             RecTransShipHeader.TESTFIELD("Vehicle No.");
//     //             RecTransShipHeader.TESTFIELD("LR/RR No.");
//     //             RecTransShipHeader.TESTFIELD("LR/RR Date");
//     //             RecTransShipHeader.TESTFIELD("Cancel Reason Code");
//     //             RecTransShipHeader.TESTFIELD("Cancel Remark");
//     //             reson := "Cancel Reason Code";
//     //             IF RecLocation.GET("Transfer-from Code") THEN BEGIN
//     //                 IF Recstate.GET(RecLocation."State Code") THEN;
//     //                 RecLocation.TESTFIELD("E-Invoice User ID");
//     //                 RecLocation.TESTFIELD("E-Invoice Password");
//     //                 Parameters := Parameters.EWayBillParameters;
//     //                 Parameters.CompanyName := COMPANYNAME;
//     //                 Parameters.FromGstin := RecLocation."GST Registration No.";
//     //                 Parameters.TransactionType := '3';
//     //                 Parameters.CancelRemarks := "Cancel Remark";
//     //                 Parameters.CancelReasonCode := FORMAT(reson);
//     //                 Parameters.EWayBillNo := "E-Way Bill No.";
//     //                 Parameters.InvoiceNo := "No.";
//     //                 Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //                 Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //                 Parameters.UserId := USERID;
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.CancelEwBill(Parameters);
//     //                 //**
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     SuccessText := EwayCanSucess;
//     //                     "E-Way Bill No." := '';
//     //                     "E-Way Bill Date" := 0DT;
//     //                     //"Sub Supply Type":="Sub Supply Type"::Supply;
//     //                     //"Update Vehicle Reason Remark":='';
//     //                     "Vehicle Type" := "Vehicle Type"::" ";
//     //                     //"Vehicle Update Reason":="Vehicle Update Reason"::"1";
//     //                     //"E-Way Bill Valid Upto":=0DT;
//     //                     "Cancel Reason Code" := CancelReasonCode;
//     //                     "Cancel Remark" := CancelRemark;
//     //                     MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += RecTransShipHeader."No."
//     //                     ELSE BEGIN
//     //                         EwayServerErrorEntry(FALSE, RecTransShipHeader."No.", Result, '', '', EWayOperation::"Cancel EWB", USERID);
//     //                         ErrorText += RecTransShipHeader."No.";
//     //                     END;
//     //                 //**
//     //             END;
//     //         UNTIL RecTransShipHeader.NEXT = 0;
//     //     END;
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text009, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);
//     //     //Cancel E-Way for Transfer--
//     // end;


//     // procedure "BulkExtendE-WayBillTransfer"(var RecTransShipHeader: Record "5744"; RemainingDistance: Decimal)
//     // begin
//     //     //Extend E-Way for Transfer++
//     //     WITH RecTransShipHeader DO BEGIN
//     //         REPEAT
//     //             RecTransShipHeader.TESTFIELD("E-Way Bill No.");
//     //             RecTransShipHeader.TESTFIELD("Vehicle No.");
//     //             RecTransShipHeader.TESTFIELD("LR/RR No.");
//     //             RecTransShipHeader.TESTFIELD("LR/RR Date");
//     //             // RecTransShipHeader.TESTFIELD("Remaining Distance");
//     //             //  reson:= "Vehicle Update Reason";
//     //             IF RecLocation.GET("Transfer-from Code") THEN BEGIN
//     //                 RecLocation.TESTFIELD("E-Invoice User ID");
//     //                 RecLocation.TESTFIELD("E-Invoice Password");
//     //                 IF Recstate.GET(RecLocation."State Code") THEN;
//     //                 Parameters := Parameters.EWayBillParameters;
//     //                 Parameters.CompanyName := COMPANYNAME;
//     //                 Parameters.InvoiceNo := "No.";
//     //                 Parameters.TransactionType := '3';
//     //                 Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //                 Parameters.EWayBillNo := "E-Way Bill No.";
//     //                 Parameters.FromGstin := RecLocation."GST Registration No.";
//     //                 Parameters.VehicleNo := "Vehicle No.";
//     //                 Parameters.FromPlace := RecLocation.City;
//     //                 Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //                 Parameters.RemainingDistance := '';//FORMAT("Remaining Distance");
//     //                 Parameters.TransDocNo := "LR/RR No.";
//     //                 Parameters.TransDocDate := FORMAT("LR/RR Date", 10, '<Day,2>/<Month,2>/<Year4>');
//     //                 Parameters.ExtensionRemarks := 'test';//007
//     //                 Parameters.ExtensionReasonCode := '1';//007
//     //                 Parameters.TransMode := "Transport Method";
//     //                 Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //                 Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //                 Parameters.UserId := USERID;
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.ExtendEwbValidity(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     SuccessText := ExSucess;
//     //                     //"Remaining Distance":=RemainingDistance;
//     //                     MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += "No."
//     //                     ELSE BEGIN
//     //                         EwayServerErrorEntry(FALSE, "No.", Result, '', '', EWayOperation::"Extend Validity of EWB", USERID);
//     //                         ErrorText += "No.";
//     //                     END;
//     //             END;
//     //         //***
//     //         UNTIL RecTransShipHeader.NEXT = 0;
//     //     END;

//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text008, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);
//     //     //Extend E-Way for Transfer--
//     // end;

//     // local procedure "***************** Bulk eWay Generation Purchase Return*******************"()
//     // begin
//     // end;


//     // procedure GetDistancePurRe(var RecPCMH: Record "124"; TransportMethod: Code[20])
//     // var
//     //     origin: Code[20];
//     //     dest: Code[20];
//     //     DistOuptput: Decimal;
//     //     RecTransportMethod: Record "259";
//     // begin
//     //     REPEAT
//     //         IF RecLocation.GET(RecPCMH."Location Code") THEN;
//     //         RecLocation.TESTFIELD("Post Code");
//     //         RecPCMH.TESTFIELD("Ship-to Post Code");
//     //         EVALUATE(origin, RecLocation."Post Code");
//     //         EVALUATE(dest, RecPCMH."Ship-to Post Code");
//     //         IF RecTransportMethod.GET(TransportMethod) THEN;
//     //         RecTransportMethod.TESTFIELD(RecTransportMethod.Description);
//     //         EwayBillDLL := EwayBillDLL.Nav;
//     //         // DistOuptput:=EwayBillDLL.GetDistance(origin,dest,RecTransportMethod.Description);
//     //         RecPCMH.Distance := DistOuptput;
//     //         RecPCMH."Transport Method" := TransportMethod;
//     //         RecPCMH.MODIFY;
//     //     UNTIL RecPCMH.NEXT = 0;
//     // end;


//     // procedure UpdateVehicleDetailsPurRet(var RecPCMH: Record "124"; VehicleNo: Code[20]; LRNo: Code[20]; LRDate: Date; VehicleType: Option " ",Regular,ODC; SupplyType: Option " ",Supply,Export,"For Own Use",Others,"Exhibition or Fairs")
//     // begin
//     //     WITH RecPCMH DO BEGIN
//     //         "Vehicle No." := VehicleNo;
//     //         //"LR/RR No.":=LRNo;
//     //         // "LR/RR Date":=LRDate;
//     //         "Vehicle Type" := VehicleType;
//     //         //"Sub Supply Type":=SupplyType;
//     //         MODIFY;
//     //     END;
//     // end;


//     // procedure "Bulk E-WayBillGenerationPurRet"(var RecPCMH: Record "124"; Print: Boolean)
//     // var
//     //     RecSInvL: Record "113";
//     // begin
//     //     //Generate eWay Bill No. for Purchase Return++
//     //     ErrorText := '';
//     //     SuccessText := '';
//     //     VARVehicleType := RecPCMH."Vehicle Type";

//     //     RecLocation.GET(RecPCMH."Location Code");
//     //     RecLocation.TESTFIELD("GST Registration No.");
//     //     RecLocation.TESTFIELD("E-Invoice User ID");
//     //     RecLocation.TESTFIELD("E-Invoice Password");
//     //     EwayBillDLL := EwayBillDLL.Nav;
//     //     //IF ISNULL(ewbSession) THEN;
//     //     //ewbSession := EwayBillDLL.GetAuthToken(COMPANYNAME,RecLocation."GST Registration No.", RecLocation."E-Invoice User ID", RecLocation."E-Invoice Password",USERID).Result; // Get Authentication Token

//     //     REPEAT
//     //         RecGeneLedSetup.GET;
//     //         RecPCMH.CALCFIELDS("Amount to Vendor");
//     //         IF (RecPCMH."Amount to Vendor" >= RecGeneLedSetup."E-Way Amount Limit") AND (RecPCMH.Distance >= RecGeneLedSetup."E-Way Distance Limit") THEN BEGIN
//     //             RecPCMH.TESTFIELD("E-Way Bill No.", '');
//     //             RecPCMH.TESTFIELD("Posting Date");
//     //             //RecPCMH.TESTFIELD("Location GST Reg. No.");
//     //             // RecPCMH.TESTFIELD("Vendor GST Reg. No.");
//     //             RecPCMH.TESTFIELD("Location Code");
//     //             RecPCMH.TESTFIELD("Buy-from Post Code");

//     //             //RecPCMH.TESTFIELD("GST Bill-from Post Code" );
//     //             // RecPCMH.TESTFIELD(Distance);
//     //             RecPCMH.TESTFIELD("Vehicle No.");
//     //             //  RecPCMH.TESTFIELD("LR/RR No.");
//     //             // RecPCMH.TESTFIELD("LR/RR Date");
//     //             RecPCML.RESET;
//     //             RecPCML.SETRANGE("Document No.", RecPCMH."No.");
//     //             RecPCML.SETRANGE(Type, RecSInvL.Type::Item);
//     //             IF RecPCML.FINDSET THEN
//     //                 REPEAT
//     //                     RecPCML.TESTFIELD(RecPCML."HSN/SAC Code")
//     //                 UNTIL RecPCML.NEXT = 0;
//     //             RecLocation.GET(RecPCMH."Location Code");
//     //             RecLocation.TESTFIELD("Post Code");
//     //             RecLocation.TESTFIELD("GST Registration No.");
//     //             RecLocation.TESTFIELD("State Code");
//     //             RecLocation.TESTFIELD("E-Invoice User ID");
//     //             RecLocation.TESTFIELD("E-Invoice Password");

//     //             //Test:=EwayBillDLL.GenEwBillForSales(RecSIH."No.",COMPANYNAME,'O',ewbSession,'1','INV','',RecLocation."E-Invoice User ID",RecLocation."E-Invoice Password",USERID,FORMAT(VARVehicleType));
//     //             // Test:=EwayBillDLL.GenEwBillForSales(RecPCMH."No.",COMPANYNAME,'O','1','INV','',RecLocation."E-Invoice User ID",RecLocation."E-Invoice Password",USERID,FORMAT(VARVehicleType));

//     //             IF Print THEN
//     //                 PrintEwayBillSales(RecPCMH."E-Way Bill No.", RecLocation."GST Registration No.", RecLocation."E-Invoice User ID", RecLocation."E-Invoice Password");
//     //             IF COPYSTR(Test, 1, 10) = 'E-Way Bill' THEN
//     //                 SuccessText := Text002
//     //             ELSE
//     //                 IF COPYSTR(Test, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                     ErrorText += RecPCMH."No."
//     //                 ELSE BEGIN
//     //                     EwayServerErrorEntry(FALSE, RecPCMH."No.", Test, '', '', EWayOperation::"Generate EWB", USERID);
//     //                     ErrorText += RecPCMH."No.";
//     //                 END;
//     //         END ELSE
//     //             ERROR('Check E-Way Amount and E-Way Distance Limit in General Ledger Setup');

//     //     UNTIL RecPCMH.NEXT = 0;

//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text001, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);

//     //     //Generate eWay Bill No. for Purchase Return--
//     // end;


//     // procedure "Bulk E-WayUpdteVehicleNoPurRet"(var RecPCMH: Record "124"; UpdateVehicleReasonRemark: Text[50]; VehicleUpdateReason: Option "1","2","3","4"; newvehicleno: Code[20])
//     // var
//     //     CommaCount: Integer;
//     //     TotalStrCount: Integer;
//     //     I: Integer;
//     //     SeparateString: Text;
//     // begin
//     //     //Update Vehicle No. For Purchase Return++
//     //     errormsg := '';
//     //     WITH RecPCMH DO BEGIN
//     //         VARVehicleType := "Vehicle Type";
//     //         REPEAT
//     //             TESTFIELD("E-Way Bill No.");
//     //             TESTFIELD("Vehicle No.");
//     //             //  TESTFIELD("LR/RR No.");
//     //             // TESTFIELD("LR/RR Date");

//     //             IF RecLocation.GET("Location Code") THEN BEGIN
//     //                 RecLocation.TESTFIELD("E-Invoice User ID");
//     //                 RecLocation.TESTFIELD("E-Invoice Password");
//     //                 IF Recstate.GET(State) THEN;
//     //                 Parameters := Parameters.EWayBillParameters;
//     //                 Parameters.CompanyName := COMPANYNAME;
//     //                 Parameters.FromGstin := RecLocation."GST Registration No.";
//     //                 Parameters.EWayBillNo := "E-Way Bill No.";
//     //                 Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //                 Parameters.VehicleNo := "Vehicle No.";
//     //                 Parameters.FromPlace := RecLocation.City;
//     //                 Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //                 Parameters.ReasonCode := FORMAT(VehicleUpdateReason);
//     //                 Parameters.Remarks := '';//"Update Vehicle Reason Remark";
//     //                 Parameters.TransDocNo := '';//"LR/RR No.";
//     //                 Parameters.TransDocDate := '';//FORMAT("LR/RR Date",10,'<Day,2>/<Month,2>/<Year4>');
//     //                 Parameters.TransMode := "Transport Method";
//     //                 Parameters.VehicleType := FORMAT(VARVehicleType);
//     //                 Parameters.InvoiceNo := "No.";
//     //                 Parameters.TransactionType := '4';
//     //                 Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //                 Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //                 Parameters.UserId := USERID;
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.UpdateVehicleNo(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     SuccessText := VehSucess;
//     //                     //"Update Vehicle Reason Remark":=UpdateVehicleReasonRemark;
//     //                     //"Vehicle Update Reason":=VehicleUpdateReason;
//     //                     "Vehicle No." := newvehicleno;
//     //                     MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += "No."
//     //                     ELSE BEGIN
//     //                         EwayServerErrorEntry(FALSE, "No.", Result, '', '', EWayOperation::"Update Vehicle No.", USERID);
//     //                         ErrorText += "No.";
//     //                     END;
//     //                 //**
//     //             END;
//     //         UNTIL NEXT = 0;
//     //     END;
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text005, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);
//     //     //Update Vehicle No. For Purchase Return--
//     // end;


//     // procedure "Bulk CancelE-WayBillPurRet"(var RecPCMH: Record "124"; CancelRemark: Text[50]; CancelReasonCode: Option "0","1","2","3","4")
//     // begin
//     //     //Cancel E-Way for Purchase Return++
//     //     errormsg := '';
//     //     reson := CancelReasonCode;
//     //     WITH RecPCMH DO BEGIN
//     //         REPEAT
//     //             TESTFIELD("E-Way Bill No.");
//     //             TESTFIELD("Vehicle No.");
//     //             //  TESTFIELD("LR/RR No.");
//     //             //  TESTFIELD("LR/RR Date");
//     //             IF RecLocation.GET("Location Code") THEN BEGIN
//     //                 IF Recstate.GET(State) THEN;
//     //                 RecLocation.TESTFIELD("E-Invoice User ID");
//     //                 RecLocation.TESTFIELD("E-Invoice Password");
//     //                 Parameters := Parameters.EWayBillParameters;
//     //                 Parameters.CompanyName := COMPANYNAME;
//     //                 Parameters.FromGstin := RecLocation."GST Registration No.";
//     //                 Parameters.TransactionType := '4';
//     //                 Parameters.CancelRemarks := "Cancel Remark";
//     //                 Parameters.CancelReasonCode := FORMAT(reson);
//     //                 Parameters.EWayBillNo := "E-Way Bill No.";
//     //                 Parameters.InvoiceNo := "No.";
//     //                 Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //                 Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //                 Parameters.UserId := USERID;
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.CancelEwBill(Parameters);
//     //                 //**
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     SuccessText := EwayCanSucess;
//     //                     "E-Way Bill No." := '';
//     //                     "E-Way Bill Date" := 0DT;
//     //                     //"Sub Supply Type":="Sub Supply Type"::Supply;
//     //                     //"Update Vehicle Reason Remark":='';
//     //                     "Vehicle Type" := "Vehicle Type"::" ";
//     //                     //   "Vehicle Update Reason":="Vehicle Update Reason"::"1";
//     //                     //"E-Way Bill Valid Upto":=0DT;
//     //                     "Cancel Reason Code" := CancelReasonCode;
//     //                     "Cancel Remark" := CancelRemark;
//     //                     MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += "No."
//     //                     ELSE BEGIN
//     //                         EwayServerErrorEntry(FALSE, "No.", Result, '', '', EWayOperation::"Cancel EWB", USERID);
//     //                         ErrorText += "No.";
//     //                     END;
//     //                 //**
//     //             END;
//     //         UNTIL NEXT = 0;
//     //     END;
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text009, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);
//     //     //Cancel E-Way for Purchase Return--
//     // end;


//     // procedure "BulkExtendE-WayBillPurRet"(var RecPCMH: Record "124"; RemainingDistance: Decimal)
//     // begin
//     //     //Extend E-Way for Purchase Return++
//     //     WITH RecPCMH DO BEGIN
//     //         REPEAT
//     //             TESTFIELD("E-Way Bill No.");
//     //             TESTFIELD("Vehicle No.");
//     //             // TESTFIELD("LR/RR No.");
//     //             //  TESTFIELD("LR/RR Date");
//     //             //  reson:= "Vehicle Update Reason";
//     //             IF RecLocation.GET("Location Code") THEN BEGIN
//     //                 IF Recstate.GET(State) THEN;
//     //                 RecLocation.TESTFIELD("E-Invoice User ID");
//     //                 RecLocation.TESTFIELD("E-Invoice Password");
//     //                 Parameters := Parameters.EWayBillParameters;
//     //                 Parameters.CompanyName := COMPANYNAME;
//     //                 Parameters.InvoiceNo := "No.";
//     //                 Parameters.TransactionType := '4';
//     //                 Parameters.EWayBillDate := FORMAT("E-Way Bill Date", 30, '<Day,2>/<Month,2>/<Year4> <hours12,2>:<minutes,2>:<seconds,2> <AM/PM>');
//     //                 Parameters.EWayBillNo := "E-Way Bill No.";
//     //                 Parameters.FromGstin := RecLocation."GST Registration No.";
//     //                 Parameters.VehicleNo := "Vehicle No.";
//     //                 Parameters.FromPlace := RecLocation.City;
//     //                 Parameters.FromStateCode := Recstate."State Code (GST Reg. No.)";
//     //                 txtDistance := FORMAT(RemainingDistance);
//     //                 Parameters.RemainingDistance := DELCHR(txtDistance, '=', ',');
//     //                 Parameters.TransDocNo := '';//"LR/RR No.";
//     //                 Parameters.TransDocDate := '';//FORMAT("LR/RR Date",10,'<Day,2>/<Month,2>/<Year4>');
//     //                 Parameters.ExtensionRemarks := 'test';//007
//     //                 Parameters.ExtensionReasonCode := '1';//007
//     //                 Parameters.TransMode := "Transport Method";
//     //                 Parameters.AuidLoc := RecLocation."E-Invoice User ID";
//     //                 Parameters.AuPassLoc := RecLocation."E-Invoice Password";
//     //                 Parameters.UserId := USERID;
//     //                 EwayBillDLL := EwayBillDLL.Nav;
//     //                 Result := EwayBillDLL.ExtendEwbValidity(Parameters);
//     //                 //***
//     //                 IF COPYSTR(Result, 1, 4) = 'True' THEN BEGIN
//     //                     SuccessText := ExSucess;
//     //                     //"Remaining Distance":=RemainingDistance;
//     //                     MODIFY;
//     //                 END ELSE
//     //                     IF COPYSTR(Result, 1, 19) = 'ErrorFromNICServer-' THEN
//     //                         ErrorText += "No."
//     //                     ELSE BEGIN
//     //                         EwayServerErrorEntry(FALSE, "No.", Result, '', '', EWayOperation::"Extend Validity of EWB", USERID);
//     //                         ErrorText += "No.";
//     //                     END;
//     //             END;
//     //         //***
//     //         UNTIL NEXT = 0;
//     //     END;
//     //     //Extend E-Way for Purchase Return--
//     //     IF ErrorText <> '' THEN
//     //         MESSAGE(Text008, DELSTR(ErrorText, STRLEN(ErrorText), STRLEN(ErrorText)))
//     //     ELSE
//     //         IF SuccessText <> '' THEN MESSAGE(SuccessText);
//     // end;

//     local procedure "************************** Log *******************************"()
//     begin
//     end;


//     procedure EwayServerErrorEntry(Status: Boolean; Document_No: Code[20]; Error1: Text[250]; Error2: Text[250]; Error3: Text[250]; EWayBillOperation: Option " ","Generate EWB","Update Vehicle No.","Generate CEWB","Cancel EWB","Reject EWB","Update Transporter","Extend Validity of EWB","Re-Gen CEWB","Get EWB Details","Get EWB Assign for Trans.","Get EWB Assign to Trans by GSTIN","Get EWB gen on req of Other Party","Get CEWB","Get GSTIN details","Get Transin details","Get HSN details","Print EWB"; User_ID: Code[50])
//     begin
//         //Store Error Log Entry++
//         /*
//         IF RecEWayBillEntry1.FINDLAST THEN;
//         RecEWayBillEntry.INIT;
//         RecEWayBillEntry."Entry No":=RecEWayBillEntry1."Entry No"+1;
//         RecEWayBillEntry.Status:=Status;
//         RecEWayBillEntry."E-Way Bill Operation":=EWayBillOperation;
//         RecEWayBillEntry."Document No":=Document_No;
//         RecEWayBillEntry.Error1:=Error1;
//         RecEWayBillEntry.Error2:=Error2;
//         RecEWayBillEntry."Transaction Type":=RecEWayBillEntry."Transaction Type"::"Sales Invoice";
//         RecEWayBillEntry.Error3:=Error3;
//         RecEWayBillEntry."User ID":=User_ID;
//         RecEWayBillEntry.Retrive:=TRUE;
//         RecEWayBillEntry.INSERT;
//         //Store Error Log Entry--
//         */

//     end;

// }

