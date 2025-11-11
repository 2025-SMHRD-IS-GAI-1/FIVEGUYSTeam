package com.pro.db.typehandler;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

/**
 * MyBatis가 Oracle BLOB을 Java InputStream으로 매핑할 수 있도록
 * 변환해주는 커스텀 TypeHandler
 */
// DB의 BLOB 타입을 Java의 InputStream으로 매핑
@MappedJdbcTypes(JdbcType.BLOB)
@MappedTypes(InputStream.class)
public class BlobInputStreamTypeHandler extends BaseTypeHandler<InputStream> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, InputStream parameter, JdbcType jdbcType)
            throws SQLException {
        // (INSERT/UPDATE 시)
        ps.setBinaryStream(i, parameter);
    }

    // --- [SELECT 시 이 메소드들이 호출됨] ---
    @Override
    public InputStream getNullableResult(ResultSet rs, String columnName) throws SQLException {
        Blob blob = rs.getBlob(columnName);
        return (blob != null) ? blob.getBinaryStream() : null;
    }

    @Override
    public InputStream getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        Blob blob = rs.getBlob(columnIndex);
        return (blob != null) ? blob.getBinaryStream() : null;
    }

    @Override
    public InputStream getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        Blob blob = cs.getBlob(columnIndex);
        return (blob != null) ? blob.getBinaryStream() : null;
    }
}