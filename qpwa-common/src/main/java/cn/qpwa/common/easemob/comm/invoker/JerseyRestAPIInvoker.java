package cn.qpwa.common.easemob.comm.invoker;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;
import cn.qpwa.common.easemob.api.RestAPIInvoker;
import cn.qpwa.common.easemob.comm.MessageTemplate;
import cn.qpwa.common.easemob.comm.constant.HTTPMethod;
import cn.qpwa.common.easemob.comm.utils.RestAPIUtils;
import cn.qpwa.common.easemob.comm.wrapper.BodyWrapper;
import cn.qpwa.common.easemob.comm.wrapper.HeaderWrapper;
import cn.qpwa.common.easemob.comm.wrapper.QueryWrapper;
import cn.qpwa.common.easemob.comm.wrapper.ResponseWrapper;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.NameValuePair;
import org.glassfish.jersey.client.JerseyClient;
import org.glassfish.jersey.client.JerseyWebTarget;
import org.glassfish.jersey.media.multipart.FormDataMultiPart;
import org.glassfish.jersey.media.multipart.file.FileDataBodyPart;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.File;
import java.io.IOException;

public class JerseyRestAPIInvoker implements RestAPIInvoker {

    private static final Logger log = LoggerFactory.getLogger(JerseyRestAPIInvoker.class);

    public ResponseWrapper sendRequest(String method, String url, HeaderWrapper header, BodyWrapper body, QueryWrapper query) {

        ResponseWrapper responseWrapper = new ResponseWrapper();
        ObjectNode responseNode = JsonNodeFactory.instance.objectNode();

        responseWrapper.setResponseBody(responseNode);

        if (!HTTPMethod.METHOD_GET.equalsIgnoreCase(method) && !HTTPMethod.METHOD_POST.equalsIgnoreCase(method) && !HTTPMethod.METHOD_PUT.equalsIgnoreCase(method) && !HTTPMethod.METHOD_DELETE.equalsIgnoreCase(method)) {
            String msg = MessageTemplate.print(MessageTemplate.UNKNOW_TYPE_MSG, new String[]{method, "HTTP methods"});
            responseWrapper.addError(msg);
        }
        if (StringUtils.isBlank(url)) {
            String msg = MessageTemplate.print(MessageTemplate.BLANK_OBJ_MSG, new String[]{"Parameter url"});
            responseWrapper.addError(msg);
        }
        if (!RestAPIUtils.match("http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?", url)) {
            String msg = MessageTemplate.print(MessageTemplate.INVAILID_FORMAT_MSG, new String[]{"Parameter url"});
            responseWrapper.addError(msg);
        }
        if (null == header) {
            String msg = MessageTemplate.print(MessageTemplate.BLANK_OBJ_MSG, new String[]{"Parameter header"});
            responseWrapper.addError(msg);
        }
        if (null == body || !body.validate()) {
            responseWrapper.addError(MessageTemplate.INVALID_BODY_MSG);
        }

        if (responseWrapper.hasError()) {
            return responseWrapper;
        }

        log.debug("=============Request=============");
        log.debug("Method: " + method);
        log.debug("URL: " + url);
        log.debug("Header: " + header);
        log.debug("Body: " + ((null == body) ? "" : body.getBody()));
        log.debug("Query: " + query);
        log.debug("===========Request End===========");

        JerseyClient client = RestAPIUtils.getJerseyClient(StringUtils.startsWithIgnoreCase(url, "HTTPS"));
        JerseyWebTarget target = client.target(url);

        buildQuery(target, query);

        Invocation.Builder inBuilder = target.request();

        buildHeader(inBuilder, header);

        Response response = null;
        Object b = null == body ? null : body.getBody();
        if (HTTPMethod.METHOD_GET.equals(method)) {
            response = inBuilder.get(Response.class);
        } else if (HTTPMethod.METHOD_POST.equals(method)) {
            response = inBuilder.post(Entity.entity(b, MediaType.APPLICATION_JSON), Response.class);
        } else if (HTTPMethod.METHOD_PUT.equals(method)) {
            response = inBuilder.put(Entity.entity(b, MediaType.APPLICATION_JSON), Response.class);
        } else if (HTTPMethod.METHOD_DELETE.equals(method)) {
            response = inBuilder.delete(Response.class);
        }
        responseWrapper.setResponseStatus(response.getStatus());

        String responseContent = response.readEntity(String.class);
        ObjectMapper mapper = new ObjectMapper();
        JsonFactory factory = mapper.getFactory();
        JsonParser jp;
        try {
            jp = factory.createParser(responseContent);
            responseNode = mapper.readTree(jp);
            responseWrapper.setResponseBody(responseNode);
        } catch (IOException e) {
            log.error(MessageTemplate.STR2JSON_ERROR_MSG, e);
            responseWrapper.addError(MessageTemplate.STR2JSON_ERROR_MSG);
        }

        log.debug("=============Response=============");
        log.debug(responseWrapper.toString());
        log.debug("===========Response End===========");
        return responseWrapper;
    }

    public ResponseWrapper uploadFile(String url, HeaderWrapper header, File file) {
        ResponseWrapper responseWrapper = new ResponseWrapper();
        ObjectNode responseNode = JsonNodeFactory.instance.objectNode();

        responseWrapper.setResponseBody(responseNode);

        if (StringUtils.isBlank(url)) {
            String msg = MessageTemplate.print(MessageTemplate.BLANK_OBJ_MSG, new String[]{"Parameter url"});
            responseWrapper.addError(msg);
        }
        if (!RestAPIUtils.match("http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?", url)) {
            String msg = MessageTemplate.print(MessageTemplate.INVAILID_FORMAT_MSG, new String[]{"Parameter url"});
            responseWrapper.addError(msg);
        }
        if (null == header) {
            String msg = MessageTemplate.print(MessageTemplate.BLANK_OBJ_MSG, new String[]{"Parameter header"});
            responseWrapper.addError(msg);
        }
        if (null == file || !file.exists() || !file.isFile() || !file.canRead()) {
            responseWrapper.addError(MessageTemplate.INVALID_BODY_MSG);
        }

        if (responseWrapper.hasError()) {
            return responseWrapper;
        }

        log.debug("=============Request=============");
        log.debug("URL: " + url);
        log.debug("Header: " + header);
        log.debug("File: " + ((null == file) ? "" : file.getName()));
        log.debug("===========Request End===========");

        JerseyClient client = RestAPIUtils.getJerseyClient(StringUtils.startsWithIgnoreCase(url, "HTTPS"));
        JerseyWebTarget target = client.target(url);

        Invocation.Builder inBuilder = target.request();

        buildHeader(inBuilder, header);

        FormDataMultiPart multiPart = new FormDataMultiPart();
        multiPart.bodyPart(new FileDataBodyPart("file", file, MediaType.APPLICATION_OCTET_STREAM_TYPE));

        Response response = inBuilder.post(Entity.entity(multiPart, MediaType.MULTIPART_FORM_DATA), Response.class);

        responseWrapper.setResponseStatus(response.getStatus());

        String responseContent = response.readEntity(String.class);
        ObjectMapper mapper = new ObjectMapper();
        JsonFactory factory = mapper.getFactory();
        JsonParser jp;
        try {
            jp = factory.createParser(responseContent);
            responseNode = mapper.readTree(jp);
            responseWrapper.setResponseBody(responseNode);
        } catch (IOException e) {
            log.error(MessageTemplate.STR2JSON_ERROR_MSG, e);
            responseWrapper.addError(MessageTemplate.STR2JSON_ERROR_MSG);
        }

        log.debug("=============Response=============");
        log.debug(responseWrapper.toString());
        log.debug("===========Response End===========");
        return responseWrapper;
    }

    public ResponseWrapper downloadFile(String url, HeaderWrapper header, QueryWrapper query) {
        ResponseWrapper responseWrapper = new ResponseWrapper();
        ObjectNode responseNode = JsonNodeFactory.instance.objectNode();

        responseWrapper.setResponseBody(responseNode);

        if (StringUtils.isBlank(url)) {
            String msg = MessageTemplate.print(MessageTemplate.BLANK_OBJ_MSG, new String[]{"Parameter url"});
            responseWrapper.addError(msg);
        }
        if (!RestAPIUtils.match("http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?", url)) {
            String msg = MessageTemplate.print(MessageTemplate.INVAILID_FORMAT_MSG, new String[]{"Parameter url"});
            responseWrapper.addError(msg);
        }
        if (null == header) {
            String msg = MessageTemplate.print(MessageTemplate.BLANK_OBJ_MSG, new String[]{"Parameter header"});
            responseWrapper.addError(msg);
        }

        if (responseWrapper.hasError()) {
            return responseWrapper;
        }

        log.debug("=============Request=============");
        log.debug("URL: " + url);
        log.debug("Header: " + header);
        log.debug("===========Request End===========");

        JerseyClient client = RestAPIUtils.getJerseyClient(StringUtils.startsWithIgnoreCase(url, "HTTPS"));
        JerseyWebTarget target = client.target(url);

        buildQuery(target, query);

        Invocation.Builder inBuilder = target.request();

        buildHeader(inBuilder, header);

        File file = inBuilder.get(File.class);
        responseWrapper.setResponseBody(file);

        log.debug("=============Response=============");
        log.debug("File is loaded, ready for processing.");
        log.debug("===========Response End===========");
        return responseWrapper;
    }

    private void buildHeader(Invocation.Builder inBuilder, HeaderWrapper header) {
        if (null != header && !header.getHeaders().isEmpty()) {
            for (NameValuePair nameValuePair : header.getHeaders()) {
                inBuilder.header(nameValuePair.getName(), nameValuePair.getValue());
            }
        }
    }

    private void buildQuery(JerseyWebTarget target, QueryWrapper query) {
        if (null != query && !query.getQueries().isEmpty()) {
            for (NameValuePair nameValuePair : query.getQueries()) {
                target.queryParam(nameValuePair.getName(), nameValuePair.getValue());
            }
        }
    }

}
